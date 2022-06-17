//
//  SignInResponseDTO.swift
//  Daru
//
//  Created by 재영신 on 2022/06/16.
//

import Foundation

struct CommonResponseDTO<T: Decodable>: Decodable {
    let result: String
    let data: T?
    let message: String?
    let statusCode: Int?
    let name: String?
    let timestamp: String
}
