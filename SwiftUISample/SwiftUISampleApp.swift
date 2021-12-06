//
//  SwiftUISampleApp.swift
//  SwiftUISample
//
//  Created by kangnux on 2021/12/06.
//

import SwiftUI

@main
struct SwiftUISampleApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            Home()
//            ContentView()
//                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
