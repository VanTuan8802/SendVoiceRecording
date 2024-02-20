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
    var lastSenderName: String
    var message: String
    var lastMessageType: MessageTypes
    var timeSend: Timestamp
}
