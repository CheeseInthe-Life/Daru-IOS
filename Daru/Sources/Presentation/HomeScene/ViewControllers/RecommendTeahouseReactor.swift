//
//  RecommendTeahouseReactor.swift
//  Daru
//
//  Created by 재영신 on 2022/05/31.
//

import Foundation
import ReactorKit
import RxSwift
import RxCocoa
import RxFlow

final class RecommendTeahouseReactor: Reactor, Stepper {
    
    enum Action {
        
    }
    
    enum Mutation {
        
    }
    
    struct State {
        
    }
    
    let initialState: State = .init()
    
    let steps: PublishRelay<Step> = .init()
}

