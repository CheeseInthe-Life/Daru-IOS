//
//  SignInRequestDTO.swift
//  Daru
//
//  Created by 재영신 on 2022/06/15.
//

import Foundation

enum ProviderType: String, Encodable {
    case kakao = "KAKAO"
    case apple = "APPLE"
}

struct SignInRequestDTO: Encodable {
    let providerType: ProviderType
    let providerAccessToken: String
    
    enum CodingKeys: String, CodingKey {
        case providerType = "providerName"
        case providerAccessToken
    }
}
