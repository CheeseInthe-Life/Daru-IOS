//
//  HomeReactor.swift
//  Daru
//
//  Created by 재영신 on 2022/05/17.
//

import Foundation
import ReactorKit
import RxFlow
import RxCocoa
import RxSwift

final class HomeReactor: Reactor, Stepper {
    
    var steps: PublishRelay<Step> = .init()
    
    let initialState: State = .init()
    
    enum Action {
        case moreButtonDidTap(section: Int)
    }
    
    enum Mutation {
        
    }
    
    struct State {
        
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case let .moreButtonDidTap(section):
            switch section {
            case 1:
                steps.accept(DaruStep.recommendTeahouseIsRequired)
            case 2:
                steps.accept(DaruStep.nearTeahouseIsRequired)
            default:
                break
            }
            return .empty()
        }
    }
}


