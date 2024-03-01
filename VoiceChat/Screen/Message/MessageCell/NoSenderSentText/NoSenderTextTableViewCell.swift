//
//  NoSenderTextTableViewCell.swift
//  VoiceChat
//
//  Created by Moon Dev on 20/02/2024.
//

import UIKit
import Kingfisher

class NoSenderTextTableViewCell: UITableViewCell {

    @IBOutlet weak var spaceView: UIView!
    @IBOutlet weak var avatarMatch: UIImageView!
    @IBOutlet weak var messageLb: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func bindData(isNextMessageSameSender: Bool, isLastMessage: Bool, message: Message) {
        spaceView.isHidden = !isLastMessage
        avatarMatch.isHidden = isNextMessageSameSender
        avatarMatch.kf.setImage(with: URL(string: message.senderAvatarUrl))
        messageLb.text = message.message
    }
    
}
