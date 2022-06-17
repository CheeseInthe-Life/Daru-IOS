//
//  AuthService.swift
//  Daru
//
//  Created by 재영신 on 2022/06/15.
//

import Foundation
import RxSwift

protocol AuthServiceType: AnyObject {
    func signIn(providerType: ProviderType, accessToken: String) -> Single<Result<TokenPiar?,NetworkError>>
    func verifyNickName(_ nickname: String) -> Single<Result<Verification,Error>>
    func signUp(providerType: ProviderType, accessToken: String, nickname: String, gender: Gender, date: String) -> Single<Result<TokenPiar,Error>>
}

final class AuthService: AuthServiceType {
    
    private let authNetworking: AuthNetworking
    
    init(authNetworking: AuthNetworking) {
        self.authNetworking = authNetworking
    }
    
    func signIn(providerType: ProviderType, accessToken: String) -> Single<Result<TokenPiar?, NetworkError>> {
        
        let requestDTO = SignInRequestDTO(providerType: providerType, providerAccessToken: accessToken)
        
        return authNetworking.request(.signIn(request: requestDTO))
            .map(CommonResponseDTO<TokenPiar?>.self)
            .debug()
            .map{
                if 200 ..< 300 ~= $0.statusCode {
                    return Result.success($0.data)
                } else {
                    return Result.failure(NetworkError(statusCode: $0.statusCode, message: $0.message ?? ""))
                }
            }
    }
    
    func verifyNickName(_ nickname: String) -> Single<Result<Verification, Error>> {
        
        let requestDTO = VerifyNicknameRequestDTO(nickname: nickname)
        
        return authNetworking.request(.verifyNickname(request: requestDTO))
            .map(CommonResponseDTO<Verification>.self)
            .debug()
            .map { $0.data}
            .map { Result.success($0) }
            .catch{ .just(Result.failure($0))}
    }
    
    func signUp(
        providerType: ProviderType,
        accessToken: String,
        nickname: String,
        gender: Gender,
        date: String
    ) -> Single<Result<TokenPiar, Error>> {
        
        let requestDTO = SignUpRequestDTO(
            providerType: providerType,
            providerAccessToken: accessToken,
            nickname: nickname,
            gender: gender == .notSelectGender ? nil : gender,
            birthYear: date
        )
        
        return authNetworking.request(.signUp(request: requestDTO))
            .map(CommonResponseDTO<TokenPiar>.self)
            .debug()
            .map{ $0.data }
            .map { Result.success($0) }
            .catch{ .just(Result.failure($0))}
    }
}
