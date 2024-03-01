//
//  User.swift
//  VoiceChat
//
//  Created by Moon Dev on 20/02/2024.
//

import Foundation
import FirebaseFirestore

struct User: Decodable {
    @DocumentID var id: String?
    var name: String
    var email: String
    var avatar: String
    
    init(id: String? = nil, name: String, email: String, avatar: String) {
        self.id = id
        self.name = name
        self.email = email
        self.avatar = avatar
    }
}
