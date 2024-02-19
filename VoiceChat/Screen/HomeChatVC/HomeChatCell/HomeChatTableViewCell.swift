//
//  HomeChatTableViewCell.swift
//  VoiceChat
//
//  Created by Moon Dev on 19/02/2024.
//

import UIKit
import Kingfisher

class HomeChatTableViewCell: UITableViewCell {

    @IBOutlet weak var avatarChat: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var message: UILabel!
    @IBOutlet weak var timeSend: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func bindChat(index: Int, groupChat: GroupChat, uid: String) {
        avatarChat.kf.setImage(with: URL(string: groupChat.avatarGroup))
        name.text = groupChat.nameGroup
        
        if uid == groupChat.lastMessage.lastSenderId {
            message.text = "You: \(groupChat.lastMessage.lastMessage)"
        } else {
            message.text = " \(groupChat.lastMessage.lastSender.components(separatedBy: " ").last ?? " "): \(groupChat.lastMessage.lastMessage) "
        }
        
        timeSend.text = showTimeLastMessage(from: groupChat.lastMessage.lastSentDate.dateValue())
    }
}
