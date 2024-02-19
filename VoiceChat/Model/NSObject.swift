//
//  NSObject.swift
//  VoiceChat
//
//  Created by Moon Dev on 19/02/2024.
//

import Foundation

extension NSObject {
    static var id: String {
        return String(describing: self)
    }
}
