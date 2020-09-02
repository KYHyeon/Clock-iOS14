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
        NavigationView {
            List {
                ForEach(model.cities) { city in
                    TimeView(city: city, currentDate: $currentDate)
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
        Text("").hidden().sheet(isPresented: $isAdding) {
            AddCityView(allCities: $model.allCities)
        }
    }
}

struct TimeView: View {
    var city: City
    @Binding var currentDate: Date
    
    var body: some View {
        HStack {
            VStack {
                Text(city.diffString).font(.subheadline)
                Text(city.name).font(.title)
            }
            Spacer()
            Text("\(city.date(currentDate: currentDate))").font(.title)
        }.padding()
    }
}

struct AddCityView: View {
    @State var text: String = ""
    @State var selectedItem: Int = 0
    @State private var searchText: String = ""
    @Binding var allCities: [City]
    
    var body: some View {
        VStack {
            SearchBar(text: $searchText, placeholder: "검색")
            List {
                ForEach(
                    allCities.filter {
                        self.searchText.isEmpty
                            ? true
                            : $0.name.lowercased().contains(self.searchText.lowercased())
                    },
                    id: \.self
                ) { Text($0.name) }
            }
        }
    }
}

struct WorldTimeView_Previews: PreviewProvider {
    static var previews: some View {
        WorldTimeView(model: WorldTime())
    }
}
