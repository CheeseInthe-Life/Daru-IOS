//
//  AuthService.swift
//  Daru
//
//  Created by 재영신 on 2022/06/15.
//

import Foundation
import RxSwift

protocol AuthServiceType: AnyObject {
    func signIn(providerType: ProviderType, accessToken: String) -> Single<Result<TokenPiar?,Error>>
    func verifyNickName(_ nickname: String) -> Single<Result<Verification,Error>>
}

final class AuthService: AuthServiceType {
    
    private let authNetworking: AuthNetworking
    
    init(authNetworking: AuthNetworking) {
        self.authNetworking = authNetworking
    }
    
    func signIn(providerType: ProviderType, accessToken: String) -> Single<Result<TokenPiar?, Error>> {
        
        let requestDTO = SignInRequestDTO(providerType: providerType, providerAccessToken: accessToken)
        
        return authNetworking.request(.signIn(request: requestDTO))
            .map(CommonResponseDTO<TokenPiar>.self)
            .debug()
            .map{ $0.data }
            .map { Result.success($0) }
            .catch{ .just(Result.failure($0))}
    }
    
    func verifyNickName(_ nickname: String) -> Single<Result<Verification, Error>> {
        
        let requestDTO = VerifyNicknameRequestDTO(nickname: nickname)
        
        return authNetworking.request(.verifyNickname(request: requestDTO))
            .map(CommonResponseDTO<Verification>.self)
            .debug()
            .map {
                if $0.data == nil {
                    throw NSError(domain: "abc", code: 426)
                } else {
                    return $0.data!
                }
            }
            .map { Result.success($0) }
            .catch{ .just(Result.failure($0))}
    }
}
