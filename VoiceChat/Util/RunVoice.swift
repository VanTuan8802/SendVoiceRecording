//
//  RunVoice.swift
//  VoiceChat
//
//  Created by Moon Dev on 22/02/2024.
//

import Foundation
import AVFoundation

func runVoiceRecording(urlVoice: String) {
    guard let url = URL(string: urlVoice) else {
            print("Invalid URL")
            return
        }
        
        let player: AVPlayer = AVPlayer(url: url)
        player.play()
}
