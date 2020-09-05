//
//  AddCityView.swift
//  Clock
//
//  Created by 현기엽 on 2020/09/03.
//  Copyright © 2020 현기엽. All rights reserved.
//

import SwiftUI

struct AddCityView: View {
    @State var text: String = ""
    @State var selectedItem: Int = 0
    @State private var searchText: String = ""
    var model: WorldTime
    @Binding var isPresented: Bool
    @Environment(\.managedObjectContext) var managedObjectContext

    var body: some View {
        VStack {
            HStack {
                SearchBar(text: $searchText, placeholder: "검색")
                Button(action: { self.isPresented = false }, label: {
                    Text("취소")
                })
            }.padding()
            List(model.allCities.filter {
                    self.searchText.isEmpty
                        ? true
                        : $0.name.lowercased().contains(self.searchText.lowercased())
            },//.sorted(),
                 id: \.self.1
            ) { city in
            // 오른쪽 인덱스 UILocalized​Indexed​Collation
                HStack {
                    Text(city.name)
                    Spacer()
                }
                .contentShape(Rectangle())
                .onTapGesture {
                    model.append(name: city.name, diffHour: city.diffHour)
                    isPresented = false
                }
            }
        }
    }
    
    func saveContext() {
      do {
        try managedObjectContext.save()
      } catch {
        print("Error saving managed object context: \(error)")
      }
    }
}

struct AddCityView_Previews: PreviewProvider {
    @Environment(\.managedObjectContext) static var managedObjectContext

    static var previews: some View {
        AddCityView(model: WorldTime(managedObjectContext), isPresented: Binding.constant(true))
    }
}
