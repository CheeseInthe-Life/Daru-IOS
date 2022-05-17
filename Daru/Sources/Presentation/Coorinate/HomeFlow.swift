//
//  HomeFlow.swift
//  Daru
//
//  Created by 재영신 on 2022/05/16.
//

import UIKit
import RxFlow
import Then

final class HomeFlow: Flow {
    
    var root: Presentable {
        return self.navigationController
    }
    
    private let navigationController = UINavigationController().then {
        $0.isNavigationBarHidden = true
    }
    
    func navigate(to step: Step) -> FlowContributors {
        guard let step = step as? DaruStep else { return .none }
        
        switch step {
        case .homeIsRequired:
            return navigateToHomeScene()
        default:
            return .none
        }
    }
}

extension HomeFlow {
    func navigateToHomeScene() -> FlowContributors {
        let homeReactor = HomeReactor()
        let homeVC = HomeViewController(reactor: homeReactor)
        navigationController.pushViewController(homeVC, animated: false)
        return .one(flowContributor: .contribute(withNext: homeVC))
    }
}
