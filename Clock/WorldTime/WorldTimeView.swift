//
//  WorldTimeView.swift
//  Clock
//
//  Created by 현기엽 on 2020/08/30.
//  Copyright © 2020 현기엽. All rights reserved.
//

import SwiftUI
import CoreData

struct WorldTimeView: View {
    @ObservedObject var model: WorldTime
    @FetchRequest(
        entity: City.entity(),
        sortDescriptors: [NSSortDescriptor(key: "order", ascending: true)]
    ) var cities: FetchedResults<City>
    @State private var editMode = EditMode.inactive
    @State var isAdding = false
    @Environment(\.managedObjectContext) var managedObjectContext
    
    var body: some View {
        VStack {
            NavigationView {
                ZStack {
                    WorldTimeViewList(
                        model: model,
                        cities: Binding.constant(cities),
                        editMode: $editMode
                    )
                    if cities.isEmpty {
                        Text("세계 시계 없음")
                            .font(.title)
                            .foregroundColor(.gray)
                    }
                }
                .navigationBarTitle("세계 시계")
                .navigationBarItems(
                    leading: Group {
                        if !cities.isEmpty {
                            EditButton()
                        }
                    },
                    trailing: Image(systemName: "plus").onTapGesture {
                        isAdding = true
                    }
                )
                .environment(\.editMode, $editMode)
            }
            // https://stackoverflow.com/a/57632426
            EmptyView().sheet(isPresented: $isAdding) {
                AddCityView(model: model, isPresented: $isAdding)
            }.fixedSize()
        }
    }
    
}

struct WorldTimeViewList: View {
    var model: WorldTime
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @State var currentDate = Date()
    @Binding var cities: FetchedResults<City>
    @Binding var editMode: EditMode
    
    var body: some View {
        List {
            ForEach(cities) { city in
                TimeView(city: city, currentDate: $currentDate, editMode: $editMode)
                    .onReceive(timer) { currentDate = $0 }
            }
            .onDelete {
                guard !$0.isEmpty else {
                    return
                }
                model.delete($0.map { index in
                    cities[index]
                })
            }
            .onMove { source, destination in
                guard !source.isEmpty else {
                    return
                }
                model.move(at: Array(cities), source: source, destination: destination)
            }
        }
    }
}

struct TimeView: View {
    var city: City
    @Binding var currentDate: Date
    @Binding var editMode: EditMode
    
    var body: some View {
        HStack {
            VStack {
                Text(city.diffString).font(.subheadline)
                Text(city.name ?? "").font(.title)
            }
            Spacer()
            if !editMode.isEditing {
                Text("\(city.amMark(currentDate: currentDate))")
                Text("\(city.hourMinute(currentDate: currentDate))").font(.title)
            }
        }.padding()
    }
}

struct WorldTimeView_Previews: PreviewProvider {
    @Environment(\.managedObjectContext) static var managedObjectContext
    static var previews: some View {
        WorldTimeView(model: WorldTime(managedObjectContext))
    }
}
