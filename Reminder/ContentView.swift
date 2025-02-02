//
//  ContentView.swift
//  Reminder
//
//  Created by Artem Panasenko on 02.02.2025.
//

import SwiftUI

import SwiftUI

struct ContentView: View {
    @State private var reminders: [(String, String, Date)] = []
    @State private var newTitle = ""
    @State private var newDate = Date()

    var body: some View {
        VStack(spacing: 20) {
            TextField("Введіть назву нагадування", text: $newTitle)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            DatePicker("Оберіть час", selection: $newDate, displayedComponents: [.date, .hourAndMinute])
                .datePickerStyle(CompactDatePickerStyle())

            Button("Додати нагадування") {
                if !newTitle.isEmpty {
                    reminders.append((newTitle, "Час виконати задачу!", newDate))
                    newTitle = ""
                }
            }
            .padding()
            .background(Color.green)
            .foregroundColor(.white)
            .cornerRadius(10)

            List {
                ForEach(reminders, id: \.2) { reminder in
                    VStack(alignment: .leading) {
                        Text(reminder.0).font(.headline)
                        Text("\(reminder.2, formatter: dateFormatter)").font(.subheadline).foregroundColor(.gray)
                    }
                }
            }

            Button("Запланувати всі сповіщення") {
                RemindService().scheduleMultipleReminders(reminders: reminders)
            }
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(10)
        }
        .padding()
    }

    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMM yyyy, HH:mm"
        return formatter
    }
}
