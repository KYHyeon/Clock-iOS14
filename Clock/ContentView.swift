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
                    Image(systemName: "globe")
                    Text("세계 시계")
            }
            AlarmView(model: Alarm())
                .tabItem {
                    Image(systemName: "alarm")
                    Text("알람")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
