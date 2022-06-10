//
//  NearTeahouseReactor.swift
//  Daru
//
//  Created by 재영신 on 2022/05/29.
//

import Foundation
import ReactorKit
import RxSwift
import RxCocoa
import RxFlow

final class NearTeahouseReactor: Reactor, Stepper {
    
    enum Action {
        
    }
    
    enum Mutation {
        
    }
    
    struct State {
        
    }
    
    let initialState: State = .init()
    
    let steps: PublishRelay<Step> = .init()
}
