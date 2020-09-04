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
    
    var allCities: [City] = TimeZone.knownTimeZoneIdentifiers.compactMap { identifier in
        guard let timezone = TimeZone(identifier: identifier) else { return nil }
        let diffHour = (TimeZone.current.secondsFromGMT() - timezone.secondsFromGMT()) / 3600
        var name: String = timezone.localizedName(
            for: NSTimeZone.NameStyle.shortGeneric,
            locale: Locale(identifier: "ko_KR")
        ) ?? ""
        return City(diffHour: diffHour, name: name)
    }
    
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
