//
//  TeahouseDetailReactor.swift
//  Daru
//
//  Created by 재영신 on 2022/07/05.
//

import Foundation
import ReactorKit
import RxCocoa
import RxFlow

final class TeahouseDetailReactor: Reactor, Stepper {
    
    enum Action {
        case refresh
    }
    
    enum Mutation {
        
    }
    
    struct State {
        @Pulse var sections: [TeahouseDetailSectionModel] = [
            .init(model: "", items: [.titleSection])
        ]
    }
    
    var steps: PublishRelay<Step> = .init()
    var initialState: State = .init()
}
