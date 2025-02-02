//
//  ReminderApp.swift
//  Reminder
//
//  Created by Artem Panasenko on 02.02.2025.
//

import SwiftUI
import UserNotifications

@main
struct ReminderApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate, UNUserNotificationCenterDelegate {
    let service = RemindService()
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        let center = UNUserNotificationCenter.current()
        center.delegate = self // Додаємо делегат
        service.requestNotificationPermission()
        return true
    }

    // Ця функція викликається, коли сповіщення приходить, навіть у активному стані
    func userNotificationCenter(
        _ center: UNUserNotificationCenter,
        willPresent notification: UNNotification,
        withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void
    ) {
        completionHandler([.banner, .sound]) // Показуємо банер + звук
    }
}
