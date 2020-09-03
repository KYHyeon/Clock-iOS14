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
    @Binding var allCities: [City]
    @Binding var isPresented: Bool
    
    var body: some View {
        VStack {
            HStack {
                SearchBar(text: $searchText, placeholder: "검색")
                Button(action: { self.isPresented = false }, label: {
                    Text("취소")
                })
            }.padding()
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

struct AddCityView_Previews: PreviewProvider {
    static var previews: some View {
        AddCityView(allCities: Binding.constant(WorldTime().allCities), isPresented: Binding.constant(true))
    }
}
