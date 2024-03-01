//
//  SenderTextTableViewCell.swift
//  VoiceChat
//
//  Created by Moon Dev on 20/02/2024.
//

import UIKit

class SenderTextTableViewCell: UITableViewCell {

    @IBOutlet weak var messageLb: UILabel!
    @IBOutlet weak var spaceView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

      
    }
    
    func bindData(isLastMessage: Bool, message: Message) {
        spaceView.isHidden = !isLastMessage
        messageLb.text = message.message
    }
}
