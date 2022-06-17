//
//  InputInfoReactor.swift
//  Daru
//
//  Created by 재영신 on 2022/06/17.
//

import Foundation
import ReactorKit
import RxFlow
import RxCocoa
import RxSwift

final class InputInfoReactor: Reactor, Stepper {
    
    enum Action {
        case duplicateCheck(nickname: String)
        case inputDateOfBirth(date: String)
        case selectGender(gender: Gender)
        case signUp
    }
    
    enum Mutation {
        case setIsDuplicated(isDuplicated: Bool)
        case setDate(date: String)
        case setGender(gender: Gender)
        case setNickname(nickname: String)
        case setIsSignUpSuccessed(isSignUpSuccessed: Bool)
    }
    
    struct State {
        var isDuplicated: Bool?
        var isInputCompleted: Bool
        var date: String?
        var gender: Gender?
        var nickname: String?
        var isSignUpSuccessed: Bool
    }
    
    var initialState: State = .init(isInputCompleted: false, isSignUpSuccessed: false)
    var steps: PublishRelay<Step> = .init()
    
    private let authService: AuthServiceType
    private let keyChainService: KeyChainServiceType
    private let providerType: ProviderType
    private let accessToken: String
    
    init(
        authService: AuthServiceType,
        keyChainService: KeyChainServiceType,
        providerType: ProviderType,
        accessToken: String
    ) {
        self.authService = authService
        self.keyChainService = keyChainService
        self.providerType = providerType
        self.accessToken = accessToken
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .duplicateCheck(let nickname):
            return Observable.concat ([
                authService.verifyNickName(nickname)
                    .compactMap {
                        result -> Mutation? in
                        guard case let .success(verification) = result else { return nil }
                        return Mutation.setIsDuplicated(isDuplicated: !verification.isValid)
                    }.asObservable()
                    .debug(),
                Observable.just(Mutation.setNickname(nickname: nickname))
            ])
        case .inputDateOfBirth(let date):
            return Observable.just(.setDate(date: date))
        case .selectGender(let gender):
            return Observable.just(.setGender(gender: gender))
        case .signUp:
            guard let nickname = currentState.nickname,
                  let gender = currentState.gender,
                  let date = currentState.date else {
                return .empty()
            }
            return authService.signUp(
                providerType: providerType,
                accessToken: accessToken,
                nickname: nickname,
                gender: gender,
                date: date
            ).compactMap {
                [weak self] result -> Mutation? in
                guard case let .success(tokenPiar) = result else { return nil }
                self?.keyChainService.accessToken = tokenPiar.accessToken
                self?.keyChainService.refreshToken = tokenPiar.refreshToken
                return Mutation.setIsSignUpSuccessed(isSignUpSuccessed: true)
            }.do {
                 _ in
                // 회원가입 성공 화면 전환
            }.asObservable()
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        
        switch mutation {
        case .setIsDuplicated(let isDuplicated):
            newState.isDuplicated = isDuplicated
        case .setDate(let date):
            newState.date = date
        case .setGender(let gender):
            newState.gender = gender
        case .setNickname(let nickName):
            newState.nickname = nickName
        case .setIsSignUpSuccessed(let isSignUpSuccessed):
            newState.isSignUpSuccessed = isSignUpSuccessed
        }
        
        newState.isInputCompleted = !(newState.isDuplicated ?? true) && newState.date != nil && newState.gender != nil
        return newState
    }
}
