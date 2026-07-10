//
//  AuthManager.swift
//  Sashay
//
//  Created by Райымбек Омаров on 10.07.2026.
//

import Foundation

import Combine

@Observable
class AuthManager {
    var isLoggedIn : Bool
    init() {
        self.isLoggedIn =  KeychainService().getToken() != nil ? true : false
        
    }
    
}
