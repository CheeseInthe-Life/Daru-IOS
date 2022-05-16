//
//  AppStepper.swift
//  Daru
//
//  Created by 재영신 on 2022/05/17.
//

import Foundation
import RxFlow
import RxCocoa
import RxSwift

class AppStepper: Stepper {

    let steps = PublishRelay<Step>()
    private let disposeBag = DisposeBag()

    init() {
    }

    var initialStep: Step {
        return DaruStep.mainIsRequired
    }
}
