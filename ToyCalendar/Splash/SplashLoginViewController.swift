//
//  SplashLoginViewController.swift
//  ToyCalendar
//
//  Created by sangdon.kim on 2019/10/09.
//  Copyright © 2019 YAPP. All rights reserved.
//

import UIKit
import GoogleSignIn

class SplashLoginViewController: UIViewController {
    private let notification: NotificationCenter = NotificationCenter.default
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareObservers()
    }
    
    private func prepareObservers() {
        notification.addObserver(self, selector: #selector(dismissOnComplete), name: .LoginSuccess, object: nil)
        notification.addObserver(self, selector: #selector(segueToNextStep(notification:)), name: .UserRegistrationNeeded, object: nil)
    }
    
    deinit {
        notification.removeObserver(self, name: .UserRegistrationNeeded, object: nil)
        notification.removeObserver(self, name: .LoginSuccess, object: nil)
    }
}

extension SplashLoginViewController {
    @objc private func segueToNextStep(notification: NSNotification) {
        let isInRegistrationProcess: Bool = navigationController?.viewControllers.count ?? 0 > 1
        
        if let user = notification.object as? TCUser, isInRegistrationProcess == false {
//            performSegue(withIdentifier: NickNameViewController.segueIdentifier, sender: user)
        }
    }
    
    @objc private func dismissOnComplete() {
        let isInRegistrationProcess: Bool = navigationController?.viewControllers.count ?? 0 > 1
        
        guard isInRegistrationProcess == false else {
            return
        }
        
//        (presentingViewController as? RootViewController)?.removeSplashView()
        dismiss(animated: false, completion: nil)
    }
}

extension SplashLoginViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
//        if segue.identifier == NickNameViewController.segueIdentifier {
//            if let vc = segue.destination as? NickNameViewController {
//                vc.user = sender as? TCUser
//            }
//        }
    }
}

// MARK: - IBActions
extension SplashLoginViewController {
    @IBAction func onExitButtonTapped(_ sender: UIButton) {
        
    }
    
    @IBAction func onSignUpButtonTapped(_ sender: UIButton) {
        if let signUpMethod = SignUpMethod(rawValue: sender.tag) {
            TCLoginManager.shared.presentSignUp(on: self, method: signUpMethod)
        }
    }
    
    @IBAction func onOpenServiceTermsButtonTapped(_ sender: UIButton) {
        
    }
    
    @IBAction func onOpenPrivacyTermsButtonTapped(_ sender: UIButton) {
        
    }
}

extension SplashLoginViewController: GIDSignInUIDelegate { }
