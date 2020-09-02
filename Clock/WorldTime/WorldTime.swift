//
//  WorldTime.swift
//  Clock
//
//  Created by 현기엽 on 2020/08/30.
//  Copyright © 2020 현기엽. All rights reserved.
//

import Foundation
import Combine

class WorldTime: ObservableObject {
    
    @Published private(set) var cities = [
        City(diffHour: 0, name: "서울"),
        City(diffHour: -14, name: "뉴올리언즈"),
        City(diffHour: -6, name: "나이로비")
    ]
    
    private var timerCancellable: AnyCancellable?
    
    var allCities = [
        City(diffHour: 0, name: "서울"),
        City(diffHour: 0, name: "대구"),
        City(diffHour: 0, name: "광주"),
        City(diffHour: 0, name: "의정부"),
        City(diffHour: 0, name: "울산"),
        City(diffHour: -14, name: "뉴올리언즈"),
        City(diffHour: -6, name: "나이로비")
    ]
    
    // MARK: - Intent
    func delete(_ indexSet: IndexSet) {
        cities.remove(atOffsets: indexSet)
    }
    
    func move(source: IndexSet, destination: Int) {
        cities.move(fromOffsets: source, toOffset: destination)
    }
    
    func append(city: City) {
        cities.append(city)
    }
}
