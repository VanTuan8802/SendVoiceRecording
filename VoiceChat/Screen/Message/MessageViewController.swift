//
//  MessageViewController.swift
//  VoiceChat
//
//  Created by Moon Dev on 20/02/2024.
//

import UIKit
import FirebaseAuth
import Kingfisher
import AVFAudio
import AVFoundation

class MessageViewController: UIViewController, AVAudioPlayerDelegate {

    @IBOutlet weak var avatarMatch: UIImageView!
    @IBOutlet weak var nameMatch: UILabel!
    @IBOutlet weak var messageTableView: UITableView!
    @IBOutlet weak var recordBtn: UIButton!
    @IBOutlet weak var recordView: UIView!
    @IBOutlet weak var sendBtn: UIButton!
    
    var matchUser: User?
    var matchId: String = ""
    var chatId: String = ""
    
    private let uid = Auth.auth().currentUser?.uid
    
    var listMessage: [Message] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getDataMessage()
        getDataMatch()
        setUITableView()
    }

    private func getDataMessage() {
        MessageData.shared.getListMessage(chatId: chatId) { listMessage, error in
            self.listMessage = listMessage
            self.messageTableView.reloadData()
        }
    }
    
    private func getDataMatch() {
        UserData.shared.getDataUser(uid: matchId ) { matchUser, error in
            self.matchUser = matchUser
            self.avatarMatch.kf.setImage(with: URL(string: matchUser?.avatar ?? ""))
            self.nameMatch.text = matchUser?.name
        }
    }
    
    private func setUITableView() {
        messageTableView.dataSource = self
        messageTableView.delegate = self
        messageTableView.rowHeight = UITableView.automaticDimension
        
        messageTableView.register(UINib(nibName: SenderTextTableViewCell.id, bundle: nil), forCellReuseIdentifier: SenderTextTableViewCell.id)
        messageTableView.register(UINib(nibName: SenderVoiceTableViewCell.id, bundle: nil), forCellReuseIdentifier: SenderVoiceTableViewCell.id)
        messageTableView.register(UINib(nibName: SenderSentImageTableViewCell.id, bundle: nil), forCellReuseIdentifier: SenderSentImageTableViewCell.id)
        messageTableView.register(UINib(nibName: NoSenderVoidTableViewCell.id, bundle: nil), forCellReuseIdentifier: NoSenderVoidTableViewCell.id)
        messageTableView.register(UINib(nibName: NoSenderTextTableViewCell.id, bundle: nil), forCellReuseIdentifier: NoSenderTextTableViewCell.id)
        messageTableView.register(UINib(nibName: NoSenderSentImageTableViewCell.id, bundle: nil), forCellReuseIdentifier: NoSenderSentImageTableViewCell.id)
    }
    
    @IBAction func recordAction(_ sender: Any) {
        if let path = Bundle.main.path(forResource: "nguoilaoi", ofType: "mp3") {
            let url = URL(fileURLWithPath: path)
            do {
                let audioPlayer = try AVAudioPlayer(contentsOf: url)
                audioPlayer.volume = 0.5
                audioPlayer.play()
            } catch {
                print("Error playing audio: \(error.localizedDescription)")
            }
        } else {
            print("Audio file not found")
        }
    }
    
    @IBAction func sendAction(_ sender: Any) {
        
    }
}

extension MessageViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let message = listMessage[indexPath.row]
        if message.messageType == .voice {
            if message.senderId == uid {
                let cell = tableView.dequeueReusableCell(withIdentifier: SenderVoiceTableViewCell.id, for: indexPath) as! SenderVoiceTableViewCell
                cell.message = message
            }
        }
    }
}

extension MessageViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listMessage.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard indexPath.section < listMessage.count else {
            return UITableViewCell()
        }
        
        let message = listMessage[indexPath.row]
        let isSend: Bool = message.senderId == uid
        
        if isSend {
            if message.messageType == .text {
                let cell = tableView.dequeueReusableCell(withIdentifier: SenderTextTableViewCell.id, for: indexPath) as! SenderTextTableViewCell
                cell.bindData(isLastMessage: false, message: message)
                return cell
            } else if message.messageType == .voice {
                let cell = tableView.dequeueReusableCell(withIdentifier: SenderVoiceTableViewCell.id, for: indexPath) as! SenderVoiceTableViewCell
                cell.bindData(isLastMessage: false, message: message)
                return cell
            }
            let cell = tableView.dequeueReusableCell(withIdentifier: SenderVoiceTableViewCell.id, for: indexPath) as! SenderVoiceTableViewCell
            cell.bindData(isLastMessage: false, message: message)
            return cell
        }
        
        if message.messageType == .voice {
            let cell = tableView.dequeueReusableCell(withIdentifier: NoSenderVoidTableViewCell.id, for: indexPath) as! NoSenderVoidTableViewCell
            cell.bindData(isNextMessageSameSender: false, isLastMessage: false, message: message)
            return cell
        } else if message.messageType == .voice {
            let cell = tableView.dequeueReusableCell(withIdentifier: NoSenderVoidTableViewCell.id, for: indexPath) as! NoSenderVoidTableViewCell
            cell.bindData(isNextMessageSameSender: false, isLastMessage: false, message: message)
            return cell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: NoSenderTextTableViewCell.id, for: indexPath) as! NoSenderTextTableViewCell
        cell.bindData(isNextMessageSameSender: false, isLastMessage: false, message: message)
        return cell
    }
}
