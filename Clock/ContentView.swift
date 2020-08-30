//
//  ContentView.swift
//  Clock
//
//  Created by 현기엽 on 2020/08/30.
//  Copyright © 2020 현기엽. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            WorldTimeView(model: WorldTime())
                .tabItem {
                    Image(systemName: "list.dash")
                    Text("Menu")
            }
            WorldTimeView(model: WorldTime())
                .tabItem {
                    Image(systemName: "list.dash")
                    Text("Menu")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
