//
//  MBTeaIFlow.swift
//  Daru
//
//  Created by 재영신 on 2022/05/22.
//

import Foundation
import RxFlow

final class MBTeaIFlow: Flow {
    
    var root: Presentable {
        return self.navigationController
    }
    
    private let navigationController = UINavigationController().then {
        $0.isNavigationBarHidden = true
    }
    
    func navigate(to step: Step) -> FlowContributors {
        guard let step = step as? DaruStep else { return .none }
        
        switch step {
        case .mbteaiIsRequired:
            return navigateToMBTeaIScene()
        default:
            return .none
        }
    }
}

private extension MBTeaIFlow {
    func navigateToMBTeaIScene() -> FlowContributors {
        let mbteaiVC = MBTeaIViewController()
        navigationController.pushViewController(mbteaiVC, animated: false)
        return .one(flowContributor: .contribute(withNext: mbteaiVC))
    }
}
