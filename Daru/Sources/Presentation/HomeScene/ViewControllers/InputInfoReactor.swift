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
    }
    
    enum Mutation {
        case setIsDuplicated(isDuplicated: Bool)
    }
    
    struct State {
        var isDuplicated: Bool?
    }
    
    var initialState: State = .init()
    var steps: PublishRelay<Step> = .init()
    
    private let authService: AuthServiceType
    
    init(authService: AuthServiceType) {
        self.authService = authService
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .duplicateCheck(let nickname):
            return authService.verifyNickName(nickname)
                .compactMap {
                    result -> Mutation? in
                    guard case let .success(verification) = result else { return nil }
                    return Mutation.setIsDuplicated(isDuplicated: !verification.isValid)
                }.asObservable()
                .debug()
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        
        switch mutation {
        case .setIsDuplicated(let isDuplicated):
            newState.isDuplicated = isDuplicated
        }
        
        return newState
    }
}
