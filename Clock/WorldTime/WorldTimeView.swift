//
//  WorldTimeView.swift
//  Clock
//
//  Created by 현기엽 on 2020/08/30.
//  Copyright © 2020 현기엽. All rights reserved.
//

import SwiftUI

struct WorldTimeView: View {
    @ObservedObject var model: WorldTime
    @State private var editMode = EditMode.inactive
    @State var currentDate = Date()
    @State var isAdding = false
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        VStack {
            NavigationView {
                List {
                    ForEach(model.cities) { city in
                        TimeView(city: city, currentDate: $currentDate, editMode: $editMode)
                            .onReceive(timer) { currentDate = $0 }
                    }
                    .onDelete(perform: model.delete(_:))
                    .onMove(perform: model.move(source:destination:))
                }
                .navigationBarTitle("세계 시계")
                .navigationBarItems(leading: EditButton(), trailing: Button(action: { }, label: {
                    Image(systemName: "plus").onTapGesture {
                        isAdding = true
                    }
                }))
                .environment(\.editMode, $editMode)
            }
            
            // https://stackoverflow.com/a/57632426
            EmptyView().sheet(isPresented: $isAdding) {
                AddCityView(allCities: $model.allCities, isPresented: $isAdding)
            }.fixedSize()
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
                Text(city.name).font(.title)
            }
            Spacer()
            if !editMode.isEditing {
                Text("\(city.date(currentDate: currentDate))").font(.title)
            }
        }.padding()
    }
}

struct WorldTimeView_Previews: PreviewProvider {
    static var previews: some View {
        WorldTimeView(model: WorldTime())
    }
}
