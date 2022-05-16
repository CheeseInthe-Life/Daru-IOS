//
//  AppFlow.swift
//  Daru
//
//  Created by 재영신 on 2022/05/15.
//

import UIKit
import RxFlow

final class AppFlow: Flow {
    
    var root: Presentable {
        return navigationController
    }
    
    private let navigationController = UINavigationController()
    
    func navigate(to step: Step) -> FlowContributors {
        <#code#>
    }
    
    
}
