//
//  FavoriteTeaHouseFlow.swift
//  Daru
//
//  Created by 재영신 on 2022/05/22.
//

import Foundation
import RxFlow

final class FavoriteTeaHouseFlow: Flow {
    
    var root: Presentable {
        return self.navigationController
    }
    
    private let navigationController = UINavigationController().then {
        $0.isNavigationBarHidden = true
    }
    
    deinit {
        print("\(type(of: self)) \(#function)")
    }
    
    func navigate(to step: Step) -> FlowContributors {
        guard let step = step as? DaruStep else { return .none }
        
        switch step {
        case .favoriteTeaHouseRequired:
            return navigateToFavoriteTeaHouseScene()
        default:
            return .none
        }
    }
}

private extension FavoriteTeaHouseFlow {
    func navigateToFavoriteTeaHouseScene() -> FlowContributors{
        let favoriteTeaHouseVC = FavoriteTeaHouseViewController()
        navigationController.pushViewController(favoriteTeaHouseVC, animated: false)
        return .one(flowContributor: .contribute(withNext: favoriteTeaHouseVC))
    }
}

