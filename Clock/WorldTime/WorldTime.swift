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
    var cityLists: [City] {
        [
            City(diff: "오늘, +0시간", name: "서울", date: date),
            City(diff: "오늘, -14시간", name: "뉴올리언즈", date: date),
            City(diff: "오늘, -6시간", name: "나이로비", date: date)
        ]
    }
    
    @Published var date: Date = Date()
    
    private var timerCancellable: AnyCancellable?
    
    init() {
        timerCancellable = Timer.publish(every: 1, on: .main, in: .default)
            .autoconnect()
            .assign(to: \WorldTime.date, on: self)
    }
}
