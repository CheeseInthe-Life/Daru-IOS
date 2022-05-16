//
//  MainFlow.swift
//  Daru
//
//  Created by 재영신 on 2022/05/16.
//

import UIKit
import RxFlow

final class MainFlow: Flow {
    
    var root: Presentable {
        return self.navigationController
    }
    
    private let navigationController = UINavigationController()
    
    func navigate(to step: Step) -> FlowContributors {
        guard let step = step as? DaruStep else { return .none }
        
        switch step {
        case .mainIsRequired:
            return navigateToMainScene()
        default:
            return .none
        }
    }
}

extension MainFlow {
    func navigateToMainScene() -> FlowContributors {
        let homeFlow = HomeFlow()
        let myDaruFlow = MyDaruFlow()
        let communityFlow = CommunityFlow()
        let teaHouseMapFlow = TeahouseMapFlow()
        Flows.use([homeFlow, myDaruFlow, communityFlow, teaHouseMapFlow], when: .created) { [unowned self] roots in
            let tabVC = TabViewController(viewControllers: roots)
            self.navigationController.pushViewController(tabVC, animated: false)
        }
        return .multiple(flowContributors: [
            .contribute(withNextPresentable: homeFlow, withNextStepper: OneStepper(withSingleStep: DaruStep.homeIsRequired)),
            .contribute(withNextPresentable: myDaruFlow, withNextStepper: OneStepper(withSingleStep: DaruStep.myPageIsRequired)),
            .contribute(withNextPresentable: communityFlow, withNextStepper: OneStepper(withSingleStep: DaruStep.communityIsRequired)),
            .contribute(withNextPresentable: teaHouseMapFlow, withNextStepper: OneStepper(withSingleStep: DaruStep.teahouseMapIsRequired))
        ]
        )
    }
}
