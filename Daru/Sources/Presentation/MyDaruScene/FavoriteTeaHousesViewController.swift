//
//  FavoriteTeaHousesViewController.swift
//  Daru
//
//  Created by 재영신 on 2022/05/22.
//

import UIKit
import RxFlow
import RxCocoa

final class FavoriteTeaHouseViewController: BaseViewController, Stepper {
    
    var steps: PublishRelay<Step> = .init()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}
