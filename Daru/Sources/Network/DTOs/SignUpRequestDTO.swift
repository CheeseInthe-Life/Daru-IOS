//
//  SignUpRequestDTO.swift
//  Daru
//
//  Created by 재영신 on 2022/06/17.
//

import Foundation

struct SignUpRequestDTO: Encodable {
    let providerType: ProviderType
    let providerAccessToken: String
    let nickname: String
    let gender: Gender?
    let birthYear: String
    
    enum CodingKeys: String, CodingKey {
        case providerType = "providerName"
        case providerAccessToken
        case nickname
        case gender
        case birthYear
    }
}
