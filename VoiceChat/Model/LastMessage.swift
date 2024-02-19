//
//  LastMessage.swift
//  VoiceChat
//
//  Created by Moon Dev on 19/02/2024.
//

import Foundation
import FirebaseFirestore

struct LastMessage: Codable {
    var lastSenderId: String
    var lastSender: String
    var lastMessage: String
    var lastSentDate: Timestamp
}
