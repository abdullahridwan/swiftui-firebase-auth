//
//  swiftui_firebase_authApp.swift
//  Shared
//
//  Created by Abdullah Ridwan on 5/27/21.
//

import SwiftUI
import Firebase

@main
struct swiftui_firebase_authApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup{
            let viewModel = AppViewModel()
            ContentView()
                .environmentObject(viewModel)
        }
    }
}



class AppDelegate: NSObject, UIApplicationDelegate{
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) ->  Bool{
        FirebaseApp.configure()
        return true
    }
}
