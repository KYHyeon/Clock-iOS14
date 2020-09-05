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
        self .managedObjectContext = managedObjectContext
    }
    
    var allCities: [(diffHour: Int, name: String)] = TimeZone.knownTimeZoneIdentifiers.compactMap { identifier in
        guard let timezone = TimeZone(identifier: identifier) else { return nil }
        let diffHour = (TimeZone.current.secondsFromGMT() - timezone.secondsFromGMT()) / 3600
        var name: String = timezone.localizedName(
            for: NSTimeZone.NameStyle.shortGeneric,
            locale: Locale(identifier: "ko_KR")
        ) ?? ""
        return (diffHour: diffHour, name: name)
    }
    
    // MARK: - Intent
    func delete(_ cities: [City]) {
        cities.forEach { city in
           self.managedObjectContext.delete(city)
         }
    }

//    func move(source: IndexSet, destination: Int) {
//        cities.move(fromOffsets: source, toOffset: destination)
//    }
//
    func append(name: String, diffHour: Int) {
        let city = City(context: managedObjectContext)
        city.name = name
        city.diffHour = Int32(diffHour)
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
