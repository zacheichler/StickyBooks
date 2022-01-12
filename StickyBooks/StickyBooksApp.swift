//
//  StickyBooksApp.swift
//  StickyBooks
//
//  Created by Zach Eichler on 2021-12-02.
//
import CoreData
import SwiftUI

@main
struct StickyBooksApp: App {
    @StateObject private var dataController = DataController()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
