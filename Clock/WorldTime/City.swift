//
//  City.swift
//  Clock
//
//  Created by 현기엽 on 2020/08/30.
//  Copyright © 2020 현기엽. All rights reserved.
//

import Foundation
import CoreData

extension City {
    var diffString: String {
        "오늘, \(diffHour)시간"
    }
     
    var dateFormatter: DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "hh:mm:ss"
        return dateFormatter
    }
    
    func date(currentDate: Date) -> String {
        dateFormatter.string(from: Date(timeInterval: TimeInterval(60 * 60 * diffHour), since: currentDate))
    }
    
    static func withName(_ name: String, context: NSManagedObjectContext) -> City? {
        let request = NSFetchRequest<City>(entityName: "City")
        request.predicate = NSPredicate(format: "name = %@", name)
        request.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
        let cities = (try? context.fetch(request)) ?? []
        return cities.first
    }
}

extension City: Comparable {
    public static func < (lhs: City, rhs: City) -> Bool {
        lhs.name! < rhs.name!
    }
}
