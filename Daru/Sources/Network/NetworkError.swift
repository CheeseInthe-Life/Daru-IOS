//
//  DaruError.swift
//  Daru
//
//  Created by 재영신 on 2022/06/17.
//

import Foundation

struct NetworkError: Error {
    let statusCode: Int
    let message: String
}
