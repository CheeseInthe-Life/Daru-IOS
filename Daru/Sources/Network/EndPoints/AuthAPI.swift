//
//  AuthAPI.swift
//  Daru
//
//  Created by 재영신 on 2022/06/15.
//

import Foundation
import Moya

enum AuthAPI {
    case signIn(request: SignInRequestDTO)
    case verifyNickname(request: VerifyNicknameRequestDTO)
}

extension AuthAPI: TargetType {
    var baseURL: URL {
        return SecretConstant.baseURL
    }
    
    var path: String {
        switch self {
        case .signIn(_):
            return "api/v1/auth/sign-in"
        case .verifyNickname(_):
            return "api/v1/auth/users/nickname/verification"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .signIn(_):
            return .post
        case .verifyNickname(_):
            return .post
        }
    }
    
    var task: Task {
        switch self {
        case .signIn(let request):
            return .requestJSONEncodable(request)
        case .verifyNickname(let request):
            return .requestJSONEncodable(request)
        }
    }
    
    var headers: [String : String]? {
        return nil
    }
    
    
}
