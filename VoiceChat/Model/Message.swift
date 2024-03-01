//
//  Message.swift
//  VoiceChat
//
//  Created by Moon Dev on 21/02/2024.
//

import Foundation
import FirebaseFirestore
import Kingfisher

struct MessageForDay: Decodable {
    var day: Timestamp
    var messages: [Message]
}

struct Message: Codable {
    @DocumentID var id: String?
    var senderId: String
    var senderName: String
    var senderAvatarUrl: String
    var messageType: MessageTypes
    var message: String?
    var audioUrl: String?
    var timeAudio: String?
    var date: Timestamp
    
    init(senderId: String, senderName: String, senderAvatarUrl: String, messageType: MessageTypes, message: String? = nil, audioUrl: String? = nil, timeAudio: String? = nil, date: Timestamp) {
        self.senderId = senderId
        self.senderName = senderName
        self.senderAvatarUrl = senderAvatarUrl
        self.messageType = messageType
        self.message = message
        self.audioUrl = audioUrl
        self.timeAudio = timeAudio
        self.date = date
    }
}
