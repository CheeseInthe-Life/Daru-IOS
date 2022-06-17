//
//  HomeFlow.swift
//  Daru
//
//  Created by 재영신 on 2022/05/16.
//

import UIKit
import RxFlow
import Then
import RxCocoa

final class HomeFlow: Flow {
    
    var root: Presentable {
        return self.rootViewController
    }
    
    private let rootViewController = UINavigationController().then {
        $0.isNavigationBarHidden = true
    }
    
    deinit {
        print("\(type(of: self)) \(#function)")
    }
    
    func navigate(to step: Step) -> FlowContributors {
        guard let step = step as? DaruStep else { return .none }
        
        switch step {
        case .homeIsRequired:
            return navigateToHomeScene()
        case .nearTeahouseIsRequired:
            return navigateToNearTeahouseScene()
        case .recommendTeahouseIsRequired:
            return navigateToRecommendTeahouseScene()
        case .signUpIsRequired:
            return navigateToAgreeTermsScene()
        default:
            return .none
        }
    }
}

private extension HomeFlow {
    func navigateToHomeScene() -> FlowContributors {
        let homeReactor = HomeReactor(keyChainService: KeyChainService(), authService: AuthService(authNetworking: AuthNetworking()))
        let homeVC = HomeViewController(reactor: homeReactor)
        rootViewController.setViewControllers([homeVC], animated: false)
        return .one(flowContributor: .contribute(withNextPresentable: homeVC, withNextStepper: homeReactor))
    }
    
    func navigateToNearTeahouseScene() -> FlowContributors {
        let nearTeahouseReactor = NearTeahouseReactor()
        let nearTeahouseVC = NearTeahouseViewController(reactor: nearTeahouseReactor)
        rootViewController.navigationController?.pushViewController(nearTeahouseVC, animated: true)
        return .one(
            flowContributor: .contribute(
                withNextPresentable: nearTeahouseVC,
                withNextStepper: nearTeahouseReactor
            )
        )
    }
    
    func navigateToRecommendTeahouseScene() -> FlowContributors {
        let recommendTeahouseReactor = RecommendTeahouseReactor()
        let recommendTeahouseVC = RecommendTeahouseViewController(reactor: recommendTeahouseReactor)
        rootViewController.navigationController?.pushViewController(recommendTeahouseVC, animated: true)
        return .one(
            flowContributor: .contribute(
                withNextPresentable: recommendTeahouseVC,
                withNextStepper: recommendTeahouseReactor
            )
        )
    }
    
    func navigateToAgreeTermsScene() -> FlowContributors {
        //TODO: Change Forced Optional Unwrapping
        let signUpFlow = SignUpFlow(rootViewController: rootViewController.navigationController!)
        
        return .one(
            flowContributor: .contribute(
                withNextPresentable: signUpFlow,
                withNextStepper: OneStepper(
                    withSingleStep: DaruStep.signUpIsRequired
                )
            )
        )
    }
}
