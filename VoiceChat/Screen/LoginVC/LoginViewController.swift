//
//  LoginViewController.swift
//  VoiceChat
//
//  Created by Moon Dev on 19/02/2024.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTxt: UITextField!
    @IBOutlet weak var passwordTxt: UITextField!
    @IBOutlet weak var loginBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()


    }

    @IBAction func loginAction(_ sender: Any) {
        guard let email = emailTxt.text,
              let password = passwordTxt.text else {
            return
        }
        
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
            guard let self = self else {
                return
            }
            
            if let error = error {
                print(error)
            } else {
                let storyboard = UIStoryboard(name: HomeChatViewController.id, bundle: nil)
                let homevc = storyboard.instantiateViewController(withIdentifier: HomeChatViewController.id) as! HomeChatViewController
                let nav = UINavigationController(rootViewController: homevc)
                nav.modalPresentationStyle = .fullScreen
                self.present(nav, animated: true)
            }
        }
    }
}
