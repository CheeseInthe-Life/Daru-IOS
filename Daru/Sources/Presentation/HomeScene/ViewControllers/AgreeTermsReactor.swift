//
//  AgreeTermsReactor.swift
//  Daru
//
//  Created by 재영신 on 2022/06/16.
//

import Foundation
import RxSwift
import ReactorKit
import RxFlow
import RxCocoa

final class AgreeTermsReactor: Reactor, Stepper {
    
    enum Action {
        case checking
        case unChecking
        case allChecking
        case allUnChecking
    }
    
    enum Mutation {
        case setIsAgreeCompleted(isAgreeCompleted: Bool)
    }
    
    struct State {
        var isAgreeCompleted: Bool
    }
    
    var initialState: State = .init(isAgreeCompleted: false)
    var steps: PublishRelay<Step> = .init()
    /// max = 2
    var agreeCount: Int = 0
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .checking:
            agreeCount += 1
        case .unChecking:
            agreeCount -= 1
        case .allChecking:
            agreeCount = 2
        case .allUnChecking:
            agreeCount = 0
        }
        
        if agreeCount == 2 {
            return Observable.just(
                Mutation.setIsAgreeCompleted(
                    isAgreeCompleted: true
                )
            )
        } else {
            return Observable.just(
                Mutation.setIsAgreeCompleted(
                    isAgreeCompleted: false
                )
            )
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        
        switch mutation {
        case .setIsAgreeCompleted(let isAgreeCompleted):
            newState.isAgreeCompleted = isAgreeCompleted
        }
        
        return newState
    }
}
