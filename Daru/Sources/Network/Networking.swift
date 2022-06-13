//
//  Networking.swift
//  Daru
//
//  Created by 재영신 on 2022/06/13.
//

import Foundation
import Moya
import RxSwift

final class Networking<Target: TargetType>: MoyaProvider<Target> {
    
    init(plugins: [PluginType] = []) {
        let session = MoyaProvider<Target>.defaultAlamofireSession()
        session.sessionConfiguration.timeoutIntervalForRequest = 10
        super.init(session: session, plugins: plugins)
    }
    
    func request(_ target: Target) -> Single<Response> {
        return self.rx.request(target)
            .filterSuccessfulStatusCodes()
            .retry(2)
    }
}
