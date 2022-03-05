//
//  SaryHomeApi.swift
//  Sary flagship iOS App
//
//  Created by islam on 05/03/2022.
//

import Foundation
import Moya

enum SaryHomeApi {
    case getBanners
    case getCategories
}

extension SaryHomeApi: TargetType {
    
     
    // using postman mock server
    var baseURL: URL {
        return URL(string: "https://7731111e-c20f-48e2-8f00-073ddba237ef.mock.pstmn.io/")!
    }

    var path: String {
        switch self {
        case .getBanners:
            return "getBannars"
        case .getCategories:
            return "getCategories"
        }
    }

    var method: Moya.Method {
        switch self {
        case .getBanners:
            return .get
        case .getCategories:
            return .get
        }
    }

    var task: Task {
        switch self {
        case .getBanners:
            return .requestPlain
        case .getCategories:
            return .requestPlain
        }
    }

    var headers: [String: String]? {
        return [:]
    }
    var sampleData: Data {
        return Data()
    }
}
