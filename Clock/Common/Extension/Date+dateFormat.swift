//
//  Date+dateFormat.swift
//  Clock
//
//  Created by 현기엽 on 2020/09/06.
//  Copyright © 2020 현기엽. All rights reserved.
//

import Foundation

extension Date {
    func amMark() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "a"
        return dateFormatter.string(from: self)
    }
    
    func hourMinute() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "hh:mm"
        return dateFormatter.string(from: self)
    }
}
