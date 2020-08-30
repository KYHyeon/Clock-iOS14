//
//  City.swift
//  Clock
//
//  Created by 현기엽 on 2020/08/30.
//  Copyright © 2020 현기엽. All rights reserved.
//

import Foundation

struct City: Identifiable {
    var id: String { name }
    
    var diff: String
    var name: String
    var date: Date
    
    var dateFormatter: DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "hh:mm:ss"
        return dateFormatter
    }
    var time: String { dateFormatter.string(from: date) }
}
