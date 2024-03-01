//
//  NoSenderVoidTableViewCell.swift
//  VoiceChat
//
//  Created by Moon Dev on 20/02/2024.
//

import UIKit

class NoSenderVoidTableViewCell: UITableViewCell {

    @IBOutlet weak var avatarMatch: UIImageView!
    @IBOutlet weak var runBtn: UIButton!
    @IBOutlet weak var timeVoice: UILabel!
    @IBOutlet weak var spaceView: UIView!
    @IBOutlet weak var audioView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func bindData(isNextMessageSameSender: Bool, isLastMessage: Bool, message: Message) {
        spaceView.isHidden = !isLastMessage
        avatarMatch.isHidden = isNextMessageSameSender
        avatarMatch.kf.setImage(with: URL(string: message.senderAvatarUrl))
        timeVoice.text = message.timeAudio
    }
    
}
