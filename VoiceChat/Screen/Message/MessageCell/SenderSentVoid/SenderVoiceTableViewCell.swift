//
//  SenderVoiceTableViewCell.swift
//  VoiceChat
//
//  Created by Moon Dev on 20/02/2024.
//

import UIKit
import AVFAudio
import AVFoundation

class SenderVoiceTableViewCell: UITableViewCell {

    @IBOutlet weak var runBtn: UIButton!
    @IBOutlet weak var spaceView: UIView!
    @IBOutlet weak var audioView: UIView!
    @IBOutlet weak var timeVoice: UILabel!
    
    var message: Message?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBAction func runVoice(_ sender: AnyObject) {
        //runVoiceRecording(urlVoice: message?.audioUrl ?? "")
        print(message?.audioUrl)
        print("j")
    }
    
    func bindData(isLastMessage: Bool, message: Message) {
        spaceView.isHidden = !isLastMessage
        timeVoice.text = message.timeAudio
    }
}
