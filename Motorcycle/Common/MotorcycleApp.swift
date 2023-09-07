//
//  MotorcycleApp.swift
//  Motorcycle
//
//  Created by Azzam Ubaidillah on 07/09/23.
//

import FirebaseCore
import Resolver
import SwiftUI

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        FirebaseApp.configure()

        return true
    }
}

@main
struct MotorcycleApp: App {
    init() {
        // Register dependencies with Resolver
        Resolver.register { FirebaseUserRepository() as UserRepository }
        Resolver.register { FirebaseAuthenticationRepository() as AuthenticationRepository }
        Resolver.register { HomeViewModel() }
        Resolver.register { RegisterViewModel() }
        Resolver.register { LoginViewModel() }
    }

    @StateObject private var sessionManager = SessionManager()
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate

    var body: some Scene {
        WindowGroup {
            if sessionManager.isLoggedIn {
                // Create an instance of HomeView with HomeViewModel
                HomeView(viewModel: Resolver.resolve(HomeViewModel.self))
            } else {
                // Create an instance of LoginView with LoginViewModel
                LoginView(viewModel: Resolver.resolve(LoginViewModel.self))
            }
        }
    }
}
