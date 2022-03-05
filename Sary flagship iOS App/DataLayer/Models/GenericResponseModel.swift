//
//  GenericResponseModel.swift
//  Sary flagship iOS App
//
//  Created by islam on 05/03/2022.
//

import Foundation

struct ObjectResponse<T: Codable>: Codable {
    var result: T?
    var status: Bool?
}
