//
//  UserData.swift
//  VoiceChat
//
//  Created by Moon Dev on 21/02/2024.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

class UserData {
    static let shared = UserData()
    
    private let database = Firestore.firestore()
    
    func getDataUser(uid: String,
                     completion: @escaping(User?, Error?) -> Void) {
        database.collection(Constants.collectionUser)
            .document(uid)
            .getDocument(as: User.self) {result in
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
}
