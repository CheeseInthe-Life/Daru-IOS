//
//  KeyChainService.swift
//  Daru
//
//  Created by 재영신 on 2022/06/13.
//

import Foundation

struct KeyChainKey {
    static let accessToken = "accessToken"
}

protocol KeyChainServiceType: AnyObject {
    var accessToken: String? { get set }
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
    
}
