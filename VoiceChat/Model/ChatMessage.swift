//
//  GroupChat.swift
//  VoiceChat
//
//  Created by Moon Dev on 19/02/2024.
//

import Foundation
import FirebaseFirestore

struct ChatMessage: Codable {
    @DocumentID var id: String?
    var avatarMatch: String
    var matchID: String
    var nameMatch: String
    var lastMessage: LastMessage
}

enum MessageTypes: String, Codable {
    case text = "text"
    case voice = "voice"
}
