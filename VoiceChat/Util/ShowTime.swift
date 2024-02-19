//
//  ShowTime.swift
//  VoiceChat
//
//  Created by Moon Dev on 19/02/2024.
//

import Foundation
import FirebaseFirestoreInternal

func showTimeLastMessage(from date: Date) -> String {
    let currentDate = Date()
    let calendar = Calendar.current

    if calendar.isDate(currentDate, inSameDayAs: date) {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter.string(from: date)
    } else if calendar.isDate(currentDate, equalTo: date, toGranularity: .weekOfYear) {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE"
        return formatter.string(from: date)
    } else {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        return formatter.string(from: date)
    }
}
