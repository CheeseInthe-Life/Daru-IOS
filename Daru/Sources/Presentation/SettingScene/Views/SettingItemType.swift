//
//  SettingItemType.swift
//  Daru
//
//  Created by 재영신 on 2022/06/18.
//

import Foundation

enum SettingItemType {
    case info
    case teahouseOwner
    case terms
    case daruInfo
    case personal
    
    var title: String {
        switch self {
        case .info:
            return "회원정보"
        case .teahouseOwner:
            return "찻집 사장님이세요?"
        case .terms:
            return "이용약관"
        case .daruInfo:
            return "다루란?"
        case .personal:
            return "개인정보보호"
        }
    }
}
