//
//  DataController.swift
//  StickyBooks
//
//  Created by Zach Eichler on 2022-01-05.
//

import CoreData
import Foundation


class DataController: ObservableObject {
    let container = NSPersistentContainer(name: "StickyBooks")
    
    init() {
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Core Data failed to load \(error.localizedDescription)")
            }
            
        }
    }
}
