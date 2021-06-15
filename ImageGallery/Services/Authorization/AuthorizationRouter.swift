//
//  AuthorizationRouter.swift
//  ImageGallery
//
//  Created by Dmitry Smetankin on 15.06.2021.
//

import Foundation
import Alamofire

enum AuthorizationRouter: APIRequestRouter {
    // MARK: - Endpoints

    case authenticate(String)

    // MARK: - Routing

    var path: String {
        switch self {
        case .authenticate: return "auth"
        }
    }

    var method: HTTPMethod {
        switch self {
        case .authenticate: return .post
        }
    }

    var parameters: Parameters? {
        switch self {
        case .authenticate(let apiKey):
            return ["apiKey": apiKey]
        }
    }

    var paramsEncoding: ParameterEncoding { return JSONEncoding() }
}
