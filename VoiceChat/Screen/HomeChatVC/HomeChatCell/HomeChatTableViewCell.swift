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
        selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func bindChat(index: Int, chatMessage: ChatMessage, uid: String) {
        avatarChat.kf.setImage(with: URL(string: chatMessage.avatarMatch))
        name.text = chatMessage.nameMatch
        
        if uid == chatMessage.lastMessage.lastSenderId {
            message.text = "You: \(chatMessage.lastMessage.message)"
        } else {
            message.text = " \(chatMessage.lastMessage.message.components(separatedBy: " ").last ?? " "): \(chatMessage.lastMessage.message) "
        }
        
        timeSend.text = showTimeLastMessage(from: chatMessage.lastMessage.timeSend.dateValue())
    }
}
