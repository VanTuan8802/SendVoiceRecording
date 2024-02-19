//
//  GroupChat.swift
//  VoiceChat
//
//  Created by Moon Dev on 19/02/2024.
//

import Foundation
import FirebaseFirestore

struct GroupChat: Codable {
    @DocumentID var id: String?
    var avatarGroup: String
    var nameGroup: String
    var owner: String
    var lastMessageType: MessageTypes
    var members: [String]
    var lastMessage: LastMessage
}

enum MessageTypes: String, Codable {
    case Text = "text"
    case Photo = "voice"
}
