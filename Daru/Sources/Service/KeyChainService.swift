//
//  KeyChainService.swift
//  Daru
//
//  Created by 재영신 on 2022/06/13.
//

import Foundation

struct KeyChainKey {
    static let accessToken = "accessToken"
    static let refreshToken = "refreshToken"
}

protocol KeyChainServiceType: AnyObject {
    var accessToken: String? { get set }
    var refreshToken: String? { get set }
}

final class KeyChainService: KeyChainServiceType {
    
    var accessToken: String? {
        
        get {
            KeyChain.read(key: KeyChainKey.accessToken)
        }
        
        set {
            if let token = newValue {
                KeyChain.create(key: KeyChainKey.accessToken, token: token)
            }
        }
    }
    
    var refreshToken: String? {
        
        get {
            KeyChain.read(key: KeyChainKey.refreshToken)
        }
        
        set {
            if let token = newValue {
                KeyChain.create(key: KeyChainKey.refreshToken, token: token)
            }
        }
    }
    
}
