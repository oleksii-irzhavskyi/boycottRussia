//
//  boycottRussiaApp.swift
//  boycottRussia
//
//  Created by Oleksii Irzhavskyi on 04.05.2022.
//

import SwiftUI
import FirebaseCore
import Firebase

@main
struct boycottRussiaApp: App {
    init() {
            FirebaseApp.configure()
        }
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
