//
//  MyDaruFlow.swift
//  Daru
//
//  Created by 재영신 on 2022/05/16.
//

import UIKit
import RxFlow

final class MyDaruFlow: Flow {
    
    var root: Presentable {
        return self.navigationController
    }
    
    private let navigationController = UINavigationController().then {
        $0.isNavigationBarHidden = true
    }
    
    
    func navigate(to step: Step) -> FlowContributors {
        guard let step = step as? DaruStep else { return .none }
        
        switch step {
        case .myPageIsRequired:
            return navigateToMyDaruScene()
        default:
            return .none
        }
    }
}

private extension MyDaruFlow {
    func navigateToMyDaruScene() -> FlowContributors{
        let mbteaiFlow = MBTeaIFlow()
        let favoriteTeaHouseFlow = FavoriteTeaHouseFlow()
        
        Flows.use(
            mbteaiFlow,
            favoriteTeaHouseFlow,
            when: .created) { [unowned self] flow1Root, flow2Root in
                let myDaruTabVC = SecondaryTabViewController(tabs: [
                    ("MB.Tea.I", flow1Root),
                    ("내가 좋아하는 찻집", flow2Root)
                ])
                self.navigationController.pushViewController(myDaruTabVC, animated: false)
            }
        
        return .multiple(flowContributors: [
            .contribute(withNextPresentable: mbteaiFlow, withNextStepper: OneStepper(withSingleStep: DaruStep.mbteaiIsRequired)),
            .contribute(withNextPresentable: favoriteTeaHouseFlow, withNextStepper: OneStepper(withSingleStep: DaruStep.favoriteTeaHouseRequired))
        ])
    }
}
