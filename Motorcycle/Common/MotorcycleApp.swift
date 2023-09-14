//
//  MotorcycleApp.swift
//  Motorcycle
//
//  Created by Azzam Ubaidillah on 07/09/23.
//

import FirebaseCore
import Resolver
import SwiftUI
import OneSignalFramework

class AppDelegate: NSObject, UIApplicationDelegate {
    
    func getEnvironmentVar(_ name: String) -> String? {
        guard let rawValue = getenv(name) else { return nil }
        return String(utf8String: rawValue)
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    
        // Remove this method to stop OneSignal Debugging
        OneSignal.Debug.setLogLevel(.LL_VERBOSE)

        // OneSignal initialization
        OneSignal.initialize(getEnvironmentVar("ONESIGNAL_APP_ID") ?? "", withLaunchOptions: launchOptions)
        
        // requestPermission will show the native iOS notification permission prompt.
        // We recommend removing the following code and instead using an In-App Message to prompt for notification permission
        OneSignal.Notifications.requestPermission({ accepted in
            print("User accepted notifications: \(accepted)")
        }, fallbackToSettings: true)
        
        // Login your customer with externalId
        // OneSignal.login("EXTERNAL_ID")
        
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
        Resolver.register { FirebaseUserRepository() as UserRepository }
        Resolver.register { FirebaseProfilePhotoRepository() as ProfilePhotoRepository }
        Resolver.register { FirebaseMotorcycleRepository() as MotorcycleRepository }
        Resolver.register { FirebaseOrderRepository() as OrderRepository }

        Resolver.register { HomeViewModel()}
        Resolver.register { ProfileViewModel() }
        Resolver.register { RegisterViewModel() }
        Resolver.register { LoginViewModel() }
        Resolver.register { OrderViewModel() }
        Resolver.register { SummaryViewModel() }
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
