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
        
    }
    
    enum Mutation {
        
    }
    
    struct State {
        
    }
    
    var initialState: State = .init()
    var steps: PublishRelay<Step> = .init()
}
