//
//  WorldTime.swift
//  Clock
//
//  Created by 현기엽 on 2020/08/30.
//  Copyright © 2020 현기엽. All rights reserved.
//

import Foundation
import Combine
import CoreData

class WorldTime: ObservableObject {
    var managedObjectContext: NSManagedObjectContext
    
    init(_ managedObjectContext: NSManagedObjectContext) {
        self.managedObjectContext = managedObjectContext
    }
    
    var allCities: [(timeInterval: Int, name: String)] = TimeZone.knownTimeZoneIdentifiers.compactMap { identifier in
        guard let timezone = TimeZone(identifier: identifier) else { return nil }
        let timeInterval = timezone.secondsFromGMT() - TimeZone.current.secondsFromGMT()
        var name: String = timezone.localizedName(
            for: NSTimeZone.NameStyle.shortGeneric,
            locale: Locale(identifier: "ko_KR")
        ) ?? ""
        return (timeInterval: timeInterval, name: name)
    }
    
    // MARK: - Intent
    func delete(_ cities: [City]) {
        cities.forEach { city in
            self.managedObjectContext.delete(city)
        }
        saveContext()
    }
    
    func move(at cities: [City], source: IndexSet, destination: Int) {
        // https://stackoverflow.com/questions/59742218/swiftui-reorder-coredata-objects-in-list
        var cities = cities
        cities.move(fromOffsets: source, toOffset: destination )
        stride(
            from: cities.count - 1,
            through: 0,
            by: -1
        )
        .forEach { reverseIndex in
            cities[reverseIndex].order = Int32(reverseIndex)
        }
        saveContext()
    }
    
    func append(name: String, diffHour: Int) {
        guard let order = City.nextOrder(context: managedObjectContext) else {
            return
        }
        let city = City(context: managedObjectContext)
        city.name = name
        city.timeInterval = Int32(diffHour)
        city.order = Int32(order)
        saveContext()
    }
    
    func saveContext() {
        do {
            try managedObjectContext.save()
        } catch {
            print("Error saving managed object context: \(error)")
        }
    }
}
