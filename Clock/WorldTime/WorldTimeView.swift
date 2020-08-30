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
    @State var isEditing = false

    var body: some View {
        NavigationView {
            List {
                ForEach(model.cityLists) { city in
                    TimeView(city: city)
                }.onDelete { indexSet in
                    print(indexSet.forEach { print($0) })
                }
            }
            .environment(\.editMode, .constant(self.isEditing ? EditMode.active : EditMode.inactive))
            .animation(Animation.spring())

            .navigationBarTitle(Text("세계 시계").font(.largeTitle))
            .navigationBarItems(leading: Button(action: {
                self.isEditing.toggle()

            }, label: {
                Text("편집")
            }), trailing: Button(action: {
                
            }, label: {
                Image(systemName: "plus")
            }))
        }
    }
}

struct TimeView: View {
    var city: City
    
    var body: some View {
        HStack {
            VStack {
                Text(city.diff).font(.subheadline)
                Text(city.name).font(.title)
            }
            Spacer()
            Text(city.time).font(.title)
        }.padding()
    }
}

struct WorldTimeView_Previews: PreviewProvider {
    static var previews: some View {
        WorldTimeView(model: WorldTime())
    }
}
