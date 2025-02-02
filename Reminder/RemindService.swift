//
//  RemindService.swift
//  Reminder
//
//  Created by Artem Panasenko on 02.02.2025.
//

import Foundation
import UserNotifications


struct RemindService {
    func requestNotificationPermission() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            if let error = error {
                print("❌ Помилка дозволу: \(error.localizedDescription)")
            } else {
                print("✅ Дозвіл надано: \(granted)")
            }
        }
    }

    
    func scheduleNotification(title: String, body: String, date: Date) {
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = body
        content.sound = .default

        // Перетворюємо дату в DateComponents для тригера
        let triggerDate = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: date)
        let trigger = UNCalendarNotificationTrigger(dateMatching: triggerDate, repeats: false)

        // Запит на сповіщення
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)

        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("❌ Помилка: \(error.localizedDescription)")
            } else {
                print("✅ Сповіщення заплановане на \(date)")
            }
        }
    }
    
    func scheduleMultipleReminders(reminders: [(String, String, Date)]) {
        for (index, reminder) in reminders.enumerated() {
            let (title, body, date) = reminder
            let content = UNMutableNotificationContent()
            content.title = title
            content.body = body
            content.sound = .default

            let triggerDate = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: date)
            let trigger = UNCalendarNotificationTrigger(dateMatching: triggerDate, repeats: false)

            let request = UNNotificationRequest(identifier: "reminder_\(index)", content: content, trigger: trigger)

            UNUserNotificationCenter.current().add(request) { error in
                if let error = error {
                    print("❌ Помилка: \(error.localizedDescription)")
                } else {
                    print("✅ Сповіщення \(index + 1) заплановане на \(date)")
                }
            }
        }
    }
}
