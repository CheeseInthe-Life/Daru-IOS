//
//  SignUpFlow.swift
//  Daru
//
//  Created by 재영신 on 2022/06/17.
//

import UIKit
import RxFlow

final class SignUpFlow: Flow {
    
    var root: Presentable {
        return self.rootViewController
    }
    
    private let rootViewController: UINavigationController
    
    init(rootViewController: UINavigationController) {
        self.rootViewController = rootViewController
    }
    
    func navigate(to step: Step) -> FlowContributors {
        guard let step = step as? DaruStep else { return .none }
        
        switch step {
        case .signUpIsRequired:
            return navigateToAgreeTermsScene()
        default:
            return .none
        }
    }
}

private extension SignUpFlow {
    
    func navigateToAgreeTermsScene() -> FlowContributors {
        let agreeTermsReactor = AgreeTermsReactor()
        let agreeTermsVC = AgreeTermsViewController(reactor: agreeTermsReactor)
        
        rootViewController.pushViewController(agreeTermsVC, animated: true)
        return .one(
            flowContributor: .contribute(
                withNextPresentable: agreeTermsVC,
                withNextStepper: agreeTermsReactor
            )
        )
    }
}
