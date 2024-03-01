//
//  MessageData.swift
//  VoiceChat
//
//  Created by Moon Dev on 21/02/2024.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

class MessageData {
    static let shared = MessageData()
    
    private let database = Firestore.firestore()
    
    func getMessage(chatId: String,
                    messageId: String,
                    completion: @escaping (Message?, Error?) -> Void) -> ListenerRegistration? {
        database.collection(Constants.collectionChat)
            .document(chatId)
            .collection(Constants.collectionMessages)
            .document(messageId)
            .getDocument(as: Message.self) { result in
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
        return nil
    }
    
    func getListMessage(chatId: String,
                        completion: @escaping ([Message], Error?) -> Void) -> ListenerRegistration? {
        
        var listMessage: [Message] = []
        
        database.collection(Constants.collectionChat)
            .document(chatId)
            .collection(Constants.collectionMessages)
            .getDocuments { [weak self] snapshot, error in
                guard let self = self else { return }
                
                if let error = error {
                    completion([], error)
                    return
                }
                
                guard let messageIds = snapshot?.documents,
                      !messageIds.isEmpty else {
                    completion([], nil)
                          return
                      }
                
                for messageId in messageIds {
                    self.getMessage(chatId: chatId,
                                    messageId: messageId.documentID) { message, error in
                        if let message = message,
                           error == nil {
                            listMessage.append(message)
                        } else {
                            completion([], nil)
                        }

                        if listMessage.count == messageIds.count {
                            completion(listMessage, nil)
                        }
                    }
                }
            }
        return nil
    }
    
}

