//
//  TCLoginManager.swift
//  ToyCalendar
//
//  Created by sangdon.kim on 2019/10/09.
//  Copyright © 2019 YAPP. All rights reserved.
//

import Foundation
import FBSDKCoreKit
import FBSDKLoginKit
import GoogleSignIn

extension Notification.Name {
    public static let LoginSuccess = Notification.Name("LoginSuccess")
    public static let LogoutSuccess = Notification.Name("LogoutSuccess")
    public static let UserRegistrationNeeded = Notification.Name("UserRegistrationNeeded")
}

public enum SignUpMethod: Int {
    case kakao
    case facebook
    case google
    case email
}

class TCUser {
    let userID: String
    var uniqueID: String = ""
    let loginMethod: SignUpMethod
    var nickname: String = ""
    
    init(userID: String, loginMethod: SignUpMethod) {
        self.userID = userID
        self.loginMethod = loginMethod
    }
}

class TCLoginManager: NSObject {
    static let shared = TCLoginManager()
//    private let requestor: TCLoginDataController = TCLoginDataController()
    private let fbLoginManager: LoginManager = LoginManager()
    private let notification = NotificationCenter.default
    
    public var isLoggedIn: Bool {
        return user != nil
    }
    
    public var user: TCUser? {
        didSet {
            if let loginMethod = user?.loginMethod {
                UserDefaultsManager.LastLoginMethod.set(loginMethod.rawValue)
            }
            
            if user != nil {
                notification.post(name: .LoginSuccess, object: nil)
            } else if oldValue != nil {
                notification.post(name: .LogoutSuccess, object: nil)
            }
        }
    }
    
    override init() {
        super.init()
        restoreLoginStatus()
        prepareObservers()
    }
    
    private func restoreLastLoginMethod() -> SignUpMethod? {
        let lastLoginMethod: Int = UserDefaultsManager.LastLoginMethod.get()
        return SignUpMethod(rawValue: lastLoginMethod)
    }
    
    private func invalidateUserLogin() {
        user = nil
    }
    
    private func prepareObservers() {
        notification.addObserver(self, selector: #selector(kakaoSessionDidChange(with:)), name: .KOSessionDidChange, object: nil)
    }
}

extension TCLoginManager {
    public func register(user: TCUser, completion: @escaping (Bool) -> Void) {
//        requestor.register(user: user) { [weak self] result in
//            guard let result = result, result else {
//                completion(false)
//                return
//            }
//            self?.user = user
//            completion(true)
//        }
    }
    
    public func login(user: TCUser, completion: ((Bool) -> Void)? = nil) {
//        requestor.login(user: user) { [weak self] resultUserInfo in
//            guard let resultUserInfo = resultUserInfo else {
//                self?.notification.post(name: .UserRegistrationNeeded, object: user)
//                completion?(false)
//                return
//            }
//
//            self?.user = resultUserInfo
//            completion?(true)
//        }
    }
}

// MARK: Login
extension TCLoginManager {
    public func restoreLoginStatus() {
        guard let method = restoreLastLoginMethod() else {
            return
        }
        
        switch method {
        case .kakao:
            restoreKakaoSession()
        case .facebook:
            restoreFacebookSession()
        case .google:
            restoreGoogleSession()
        case .email:
            restoreEmailSession()
        }
    }
    
    private func restoreKakaoSession() {
        if KOSession.shared()?.isOpen() ?? false {
            KOSessionTask.userMeTask { [weak self] error, userInfo in
                guard let userID = userInfo?.id, error == nil else {
                    return
                }
                let user: TCUser = TCUser(userID: userID, loginMethod: .kakao)
                self?.login(user: user)
            }
        }
    }
    private func restoreFacebookSession() {
        if AccessToken.isCurrentAccessTokenActive, let userID = AccessToken.current?.userID {
            let user = TCUser(userID: userID, loginMethod: .facebook)
            login(user: user)
        }
    }
    
    private func restoreGoogleSession() {
        GIDSignIn.sharedInstance()?.signInSilently()
    }
    
    private func restoreEmailSession() {
        
    }
}

// MARK: Logout
extension TCLoginManager {
    public func logout() {
        guard let method = user?.loginMethod else {
            return
        }
        
        switch method {
        case .kakao:
            logoutKakaoSession()
        case .facebook:
            logoutFacebookSession()
        case .google:
            logoutGoogleSession()
        case .email:
            logoutEmailSession()
        }
    }
    
    private func logoutKakaoSession() {
        KOSession.shared()?.logoutAndClose { [weak self] result, error in
            guard result, error == nil else {
                return
            }
            if self?.user?.loginMethod == SignUpMethod.kakao {
                self?.invalidateUserLogin()
            }
        }
    }
    
    private func logoutFacebookSession() {
        fbLoginManager.logOut()
        if user?.loginMethod == SignUpMethod.facebook {
            invalidateUserLogin()
        }
    }
    
    private func logoutGoogleSession() {
        GIDSignIn.sharedInstance()?.signOut()
        if user?.loginMethod == SignUpMethod.google {
            invalidateUserLogin()
        }
    }
    
    private func logoutEmailSession() {
        
    }
}

// MARK: SignUp
extension TCLoginManager {
    public func presentSignUp(on presentingVC: UIViewController, method: SignUpMethod) {
        switch method {
        case .kakao:
            presentKakaoSignUp()
        case .facebook:
            presentFacebookSignUp(on: presentingVC)
        case .google:
            presentGoogleSignUp(on: presentingVC)
        case .email:
            presentEmailSignUp(on: presentingVC)
        }
    }
    
    private func presentKakaoSignUp() {
        let session: KOSession? = KOSession.shared()
        if session?.isOpen() ?? false {
            session?.close()
        }
        
        session?.open { [weak self] error in
            if session?.isOpen() ?? false {
                KOSessionTask.userMeTask { [weak self] error, userInfo in
                    guard let userID = userInfo?.id, error == nil else {
                        return
                    }
                    
                    let user: TCUser = TCUser(userID: userID, loginMethod: .kakao)
                    self?.login(user: user)
                }
            }
        }
    }
    
    private func presentFacebookSignUp(on viewController: UIViewController) {
        fbLoginManager.logIn(permissions: [], from: viewController) { [weak self] result, error in
            guard let token = result?.token, error == nil else {
                return
            }
            let user = TCUser(userID: token.userID, loginMethod: .facebook)
            self?.login(user: user)
        }
    }
    
    private func presentGoogleSignUp(on viewController: UIViewController) {
        if let viewController = viewController as? GIDSignInUIDelegate {
            GIDSignIn.sharedInstance()?.uiDelegate = viewController
            GIDSignIn.sharedInstance()?.signIn()
        }
    }
    
    private func presentEmailSignUp(on viewController: UIViewController) {
        
    }
}

// MARK: Unlink - 스펙 아웃, 추후 필요할 경우 구현
extension TCLoginManager {
    public func unlinkAccount() {
        guard let method = user?.loginMethod else {
            return
        }
        
        switch method {
        case .kakao:
            unlinkKakaoAccount(completion: nil)
        case .facebook:
            unlinkFacebookAccount()
        case .google:
            unlinkGoogleAccount()
        case .email:
            unlinkEmailAccount()
        }
    }
    
    private func unlinkKakaoAccount(completion: ((Bool) -> Void)? = nil) {
        KOSessionTask.unlinkTask { result, error in
            completion?(result)
        }
    }
    
    private func unlinkFacebookAccount() {
        
    }
    
    private func unlinkGoogleAccount() {
        
    }
    
    private func unlinkEmailAccount() {
        
    }
}

// MARK: Google Delegate
extension TCLoginManager: GIDSignInDelegate {
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {
        guard self.user?.loginMethod == SignUpMethod.facebook else {
            return
        }
        self.user = nil
    }
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        guard user != nil else {
            return
        }
        let user = TCUser(userID: user.userID, loginMethod: .google)
        login(user: user)
    }
}

// MARK: Kakao Delegate
extension TCLoginManager {
    @objc private func kakaoSessionDidChange(with notification: NSNotification) {
        
    }
}

