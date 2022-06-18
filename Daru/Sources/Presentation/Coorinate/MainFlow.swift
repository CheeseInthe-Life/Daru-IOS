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
        return self.rootViewController
    }
    
    private let rootViewController: TabViewController
    private let homeFlow: HomeFlow = .init()
    private let myDaruFlow: MyDaruFlow = .init()
    private let communityFlow: CommunityFlow = .init()
    private let teahouseMapFlow: TeahouseMapFlow = .init()
    
    init(tabViewController: TabViewController) {
        self.rootViewController = tabViewController
    }
    
    deinit {
        print("\(type(of: self)) \(#function)")
    }
    
    func navigate(to step: Step) -> FlowContributors {
        guard let step = step as? DaruStep else { return .none }
        
        switch step {
        case .mainIsRequired:
            return navigateToMainScene()
        case .settingIsRequired:
            return navigateToSettingScene()
        default:
            return .none
        }
    }
}

extension MainFlow {
    func navigateToMainScene() -> FlowContributors {
        Flows.use(homeFlow, myDaruFlow, communityFlow, teahouseMapFlow, when: .created) {
            [unowned self] homeRoot, myDaruRoot, communityRoot, teaHouseMapRoot in
            rootViewController.setTabs(tabs: [
                ("홈", homeRoot),
                ("나의 다루", myDaruRoot),
                ("커뮤니티", communityRoot),
                ("찻집 지도", teaHouseMapRoot)
            ])
        }
        return .multiple(flowContributors: [
            .contribute(withNextPresentable: homeFlow, withNextStepper: OneStepper(withSingleStep: DaruStep.homeIsRequired), allowStepWhenDismissed: true),
            .contribute(withNextPresentable: myDaruFlow, withNextStepper: OneStepper(withSingleStep: DaruStep.myPageIsRequired), allowStepWhenDismissed: true),
            .contribute(withNextPresentable: communityFlow, withNextStepper: OneStepper(withSingleStep: DaruStep.communityIsRequired), allowStepWhenDismissed: true),
            .contribute(withNextPresentable: teahouseMapFlow, withNextStepper: OneStepper(withSingleStep: DaruStep.teahouseMapIsRequired), allowStepWhenDismissed: true)
        ]
        )
    }
    
    func navigateToSettingScene() -> FlowContributors {
        let settingFlow = SettingFlow(rootViewController: rootViewController.navigationController!)
        
        return .one(
            flowContributor: .contribute(
                withNextPresentable: settingFlow,
                withNextStepper: OneStepper(
                    withSingleStep: DaruStep.settingIsRequired
                )
            )
        )
        
    }
}
