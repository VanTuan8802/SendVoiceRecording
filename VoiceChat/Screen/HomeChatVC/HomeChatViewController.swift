//
//  HomeChatViewController.swift
//  VoiceChat
//
//  Created by Moon Dev on 19/02/2024.
//

import UIKit
import FirebaseAuth

class HomeChatViewController: UIViewController {
    
    @IBOutlet weak var homeChatTableView: UITableView!
    
    private var listGroupChat :[ChatMessage] = []
    private let uid = Auth.auth().currentUser?.uid
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        getData()
    }
    
    private func setupTableView() {
        homeChatTableView.delegate = self
        homeChatTableView.dataSource = self
        homeChatTableView.register(UINib(nibName: HomeChatTableViewCell.id, bundle: nil), forCellReuseIdentifier: HomeChatTableViewCell.id)
        homeChatTableView.separatorStyle = .none
        homeChatTableView.showsHorizontalScrollIndicator = true
    }
    
    private func getData() {
        guard let uid = uid else {
            return
        }
        
        HomeChatData.shared.getListItem(uid: uid) { listGroupChatData, err in
            self.listGroupChat = listGroupChatData
            self.homeChatTableView.reloadData()
        }
    }
}

extension HomeChatViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 72.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: MessageViewController.id, bundle: nil)
        let homevc = storyboard.instantiateViewController(withIdentifier: MessageViewController.id) as! MessageViewController
        homevc.chatId = listGroupChat[indexPath.row].id ?? ""
        homevc.matchId = listGroupChat[indexPath.row].matchID
        let nav = UINavigationController(rootViewController: homevc)
        nav.modalPresentationStyle = .fullScreen
        self.present(nav, animated: true)
    }
}

extension HomeChatViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listGroupChat.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: HomeChatTableViewCell.id, for: indexPath) as! HomeChatTableViewCell
        if let uid = uid {
            cell.bindChat(index: indexPath.row, chatMessage: listGroupChat[indexPath.row], uid: uid)
        }
       
        return cell
    }
    
}
