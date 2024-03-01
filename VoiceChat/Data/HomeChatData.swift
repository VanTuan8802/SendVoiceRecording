//
//  HomeChatData.swift
//  VoiceChat
//
//  Created by Moon Dev on 20/02/2024.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

class HomeChatData {
    static let shared = HomeChatData()
    
    private let database = Firestore.firestore()
    
    func getItem(uid:String,
                 id: String,
                 completion: @escaping(ChatMessage?, Error?) -> Void) {
        database.collection(Constants.collectionUser)
            .document(uid)
            .collection(Constants.collectionChat)
            .document(id)
            .getDocument(as: ChatMessage.self) { result in
                switch result {
                case .success(let data):
                    completion(data, nil)
                case .failure(let error):
                    var errorMessage = "Error decoding document: \(error.localizedDescription)"
                    if case let DecodingError.typeMismatch(_, context) = error {
                        errorMessage = "\(error.localizedDescription): \(context.debugDescription)"
                    } else if case let DecodingError.valueNotFound(_, context) = error {
                        errorMessage = "\(error.localizedDescription): \(context.debugDescription)"
                    } else if case let DecodingError.keyNotFound(_, context) = error {
                        errorMessage = "\(error.localizedDescription): \(context.debugDescription)"
                    } else if case let DecodingError.dataCorrupted(key) = error {
                        errorMessage = "\(error.localizedDescription): \(key)"
                    }
                    print(errorMessage)
                    completion(nil, error)
                }
            }
    }
    
    func getListItem(uid:String,
                     completion: @escaping ([ChatMessage], Error?) -> Void) {
        database.collection(Constants.collectionUser)
             .document(uid)
             .collection(Constants.collectionChat)
             .addSnapshotListener { [weak self] snapshot, error in
                 guard let self = self else { return }
                 
                 if let error = error {
                     completion([], error)
                     return
                 }
                 
                 guard let chatMessageIds = snapshot?.documents,
                       !chatMessageIds.isEmpty else {
                     completion([], nil)
                     return
                 }
               
                 var chatMessages: [ChatMessage] = []
                 
                 for chatMessageId in chatMessageIds {
                     self.getItem(uid: uid, id: chatMessageId.documentID) { chatMessage, error in
                         if let chatMessage = chatMessage,
                            error == nil {
                             chatMessages.append(chatMessage)
                         } else {
                             completion([], nil)
                         }

                         if chatMessages.count == chatMessageIds.count {
                             completion(chatMessages, nil)
                         }
                     }
                 }
             }
    }
}
