//
//  PostListFlow.swift
//  Daru
//
//  Created by 재영신 on 2022/05/25.
//

import Foundation
import RxFlow

final class PostListFlow: Flow {
    
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
        case .postListIsRequired:
            return navigateToPostListScene()
        case .postDetailIsRequired:
            return navigateToPostDetailScene()
        default:
            return .none
        }
    }
}

private extension PostListFlow {
    
    func navigateToPostListScene() -> FlowContributors {
        let postListReactor = PostListReactor()
        let postListVC = PostListViewController(reactor: postListReactor)
        rootViewController.pushViewController(postListVC, animated: false)
        return .one(
            flowContributor: .contribute(
                withNextPresentable: postListVC,
                withNextStepper: postListReactor
            )
        )
    }
    
    func navigateToPostDetailScene() -> FlowContributors {
        let postDetailReactor = PostDetailReactor()
        let postDetailVC = PostDetailViewController(reactor: postDetailReactor)
        rootViewController.navigationController?.navigationController?.pushViewController(postDetailVC, animated: true)
        return .one(flowContributor: .contribute(
            withNextPresentable: postDetailVC,
            withNextStepper: postDetailReactor
        )
        )
    }
}
