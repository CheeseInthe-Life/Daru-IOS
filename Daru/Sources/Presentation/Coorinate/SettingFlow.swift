//
//  SettingFlow.swift
//  Daru
//
//  Created by 재영신 on 2022/06/18.
//

import UIKit
import RxFlow

final class SettingFlow: Flow {
    
    var root: Presentable {
        return self.rootViewController
    }
    
    private let rootViewController: UINavigationController
    
    init(rootViewController: UINavigationController) {
        self.rootViewController = rootViewController
    }
    
    deinit {
        print("\(type(of: self)) deinit!!!")
    }
    
    func navigate(to step: Step) -> FlowContributors {
        guard let step = step as? DaruStep else { return .none }
        
        switch step {
        case .settingIsRequired:
            return navigateToSettingScene()
        default:
            return .none
        }
        
    }
}


extension SettingFlow {
    
    func navigateToSettingScene() -> FlowContributors {
        let settingReactor = SettingReactor()
        let settingVC = SettingViewController(reactor: settingReactor)
        
        rootViewController.pushViewController(settingVC, animated: true)
        
        return .one(flowContributor: .contribute(withNextPresentable: settingVC, withNextStepper: settingReactor))
    }
}
