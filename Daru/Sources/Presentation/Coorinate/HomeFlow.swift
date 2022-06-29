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
        case let .signUpIsRequired(providerType, accessToken):
            return navigateToAgreeTermsScene(providerType: providerType, accessToken: accessToken)
        case .settingAlertIsRequired:
            return navigateToSettingAlert()
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
    
    func navigateToAgreeTermsScene(providerType: ProviderType, accessToken: String) -> FlowContributors {
        //TODO: Change Forced Optional Unwrapping
        let signUpFlow = SignUpFlow(rootViewController: rootViewController.navigationController!)
        
        return .one(
            flowContributor: .contribute(
                withNextPresentable: signUpFlow,
                withNextStepper: OneStepper(
                    withSingleStep: DaruStep.signUpIsRequired(providerType: providerType, accessToken: accessToken)
                )
            )
        )
    }
    
    func navigateToSettingAlert() -> FlowContributors {
        guard let url = URL(string: UIApplication.openSettingsURLString) else { return .none }
        
        let alert = UIAlertController(
            title: "위치 사용 권환이 필요합니다.",
            message: "위치 권환을 허용해야만 내 주변 찻집을 확인할 수 있습니다.",
            preferredStyle: .alert
        )
        
        alert.addAction(UIAlertAction(
            title: "설정하러가기",
            style: .default,
            handler: {
                _ in
                if UIApplication.shared.canOpenURL(url) {
                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                }
            }
        ))
        
        rootViewController.present(alert, animated: true)
        return .none
    }

}
