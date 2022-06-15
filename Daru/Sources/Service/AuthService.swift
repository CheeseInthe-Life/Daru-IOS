//
//  AuthService.swift
//  Daru
//
//  Created by 재영신 on 2022/06/15.
//

import Foundation
import RxSwift

protocol AuthServiceType: AnyObject {
    func signIn(providerType: ProviderType, accessToken: String) -> Single<Result<Void,Error>>
}

final class AuthService: AuthServiceType {
    
    private let authNetworking: AuthNetworking
    
    init(authNetworking: AuthNetworking) {
        self.authNetworking = authNetworking
    }
    
    func signIn(providerType: ProviderType, accessToken: String) -> Single<Result<Void, Error>> {
        
        let requestDTO = SignInRequestDTO(providerType: providerType, providerAccessToken: accessToken)
        
        return authNetworking.request(.signIn(request: requestDTO))
            .map{ _ in () }
            .map{ Result.success($0) }
            .catch{.just(Result.failure($0))}
    }
}
