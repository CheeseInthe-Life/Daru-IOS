//
//  CommunityFlow.swift
//  Daru
//
//  Created by 재영신 on 2022/05/16.
//

import UIKit
import RxFlow

final class CommunityFlow: Flow {
    
    var root: Presentable {
        return self.navigationController
    }
    
    private let navigationController = UINavigationController().then {
        $0.isNavigationBarHidden = true
    }
    
    
    func navigate(to step: Step) -> FlowContributors {
        guard let step = step as? DaruStep else { return .none }
        
        switch step {
        case .communityIsRequired:
            return navigateToCommunityScene()
        default:
            return .none
        }
    }
}

private extension CommunityFlow {
    func navigateToCommunityScene() -> FlowContributors {
        let postListFlow = PostListFlow()
        let managePostFlow = ManagePostFlow()
        
        Flows.use(
            postListFlow,
            managePostFlow,
            when: .created) { [unowned self] flow1Root, flow2Root in
                let commnityTapVC = SecondaryTabViewController(tabs: [
                    ("커뮤니티", flow1Root),
                    ("내 글 관리", flow2Root)
                ])
                self.navigationController.pushViewController(commnityTapVC, animated: false)
            }
        
        return .multiple(flowContributors: [
            .contribute(
                withNextPresentable: postListFlow,
                withNextStepper: OneStepper(withSingleStep: DaruStep.postListIsRequired),
                allowStepWhenDismissed: true
            ),
            .contribute(
                withNextPresentable: managePostFlow,
                withNextStepper: OneStepper(withSingleStep: DaruStep.managePostIsRequired),
                allowStepWhenDismissed: true
            )
        ])
    }
}
