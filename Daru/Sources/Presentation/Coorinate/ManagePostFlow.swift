//
//  ManagePostFlow.swift
//  Daru
//
//  Created by 재영신 on 2022/05/25.
//

import Foundation
import RxFlow

final class ManagePostFlow: Flow {
    
    var root: Presentable {
        return self.rootViewController
    }
    
    private let rootViewController: UINavigationController = .init()
    
    func navigate(to step: Step) -> FlowContributors {
        guard let step = step as? DaruStep else { return .none }
        
        switch step {
        case .managePostIsRequired:
            return navigateToManagePostScene()
        default:
            return .none
        }
    }
}

private extension ManagePostFlow {
    func navigateToManagePostScene() -> FlowContributors {
        let managePostVC = ManagePostViewController()
        self.rootViewController.pushViewController(managePostVC, animated: false)
        return .one(flowContributor: .contribute(withNext: managePostVC))
    }
}
