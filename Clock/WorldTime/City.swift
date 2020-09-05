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
        "오늘, \(timeInterval / 3600)시간"
    }
    
    var dateFormatter: DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "hh:mm:ss"
        return dateFormatter
    }
    
    func date(currentDate: Date) -> String {
        dateFormatter.string(from: Date(timeInterval: TimeInterval(timeInterval), since: currentDate))
    }
    
    static func withName(_ name: String, context: NSManagedObjectContext) -> City? {
        let request = NSFetchRequest<City>(entityName: "City")
        request.predicate = NSPredicate(format: "name = %@", name)
        request.sortDescriptors = []
        let cities = (try? context.fetch(request)) ?? []
        return cities.first
    }
    
    static func nextOrder(context: NSManagedObjectContext) -> Int? {
        // City를 추가할 때마다 모든 원소를 반환해야 하므로 비효율적인 코드
        let request = NSFetchRequest<City>(entityName: "City")
        request.sortDescriptors = [NSSortDescriptor(key: "order", ascending: false)]
        do {
            guard let last = try context.fetch(request).first else {
                return 1
            }
            return Int(last.order) + 1
        } catch let error {
            debugPrint(error)
            return nil
        }
    }
    
}

extension City: Comparable {
    public static func < (lhs: City, rhs: City) -> Bool {
        lhs.name! < rhs.name!
    }
}
