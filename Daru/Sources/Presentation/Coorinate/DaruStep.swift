//
//  DaruStep.swift
//  Daru
//
//  Created by 재영신 on 2022/05/16.
//

import Foundation
import RxFlow

enum DaruStep: Step {
    
    // MainTabbar
    case mainIsRequired
    
    //Home
    case homeIsRequired
    
    //MyDaru
    case myPageIsRequired
    
    //Community
    case communityIsRequired
    
    //teahouseMap
    case teahouseMapIsRequired
}
