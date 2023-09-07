//
//  MotorcycleApp.swift
//  Motorcycle
//
//  Created by Azzam Ubaidillah on 07/09/23.
//

import SwiftUI
import FirebaseCore


class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()

    return true
  }
}

@main
struct MotorcycleApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
