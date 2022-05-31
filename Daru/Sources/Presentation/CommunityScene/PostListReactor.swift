//
//  PostListReactor.swift
//  Daru
//
//  Created by 재영신 on 2022/05/31.
//

import Foundation
import ReactorKit
import RxFlow
import RxCocoa

final class PostListReactor: Reactor, Stepper {
    
    enum Action {
        
    }
    
    enum Mutation {
        
    }
    
    struct State {
        
    }
    
    var initialState: State = .init()
    var steps: PublishRelay<Step> = .init()
}
