//
//  City.swift
//  Clock
//
//  Created by 현기엽 on 2020/08/30.
//  Copyright © 2020 현기엽. All rights reserved.
//

import Foundation

struct City {
    var diffHour: Int
    var diffString: String {
        "오늘, \(diffHour)시간"
    }
    
    var name: String
    
    var dateFormatter: DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "hh:mm:ss"
        return dateFormatter
    }
    
    func date(currentDate: Date) -> String {
        dateFormatter.string(from: Date(timeInterval: TimeInterval(60 * 60 * diffHour), since: currentDate))
    }
}

extension City: Identifiable {
    var id: String { name }
}

extension City: Hashable { }

extension City: Comparable {
    static func < (lhs: City, rhs: City) -> Bool {
        lhs.name < rhs.name
    }
}
