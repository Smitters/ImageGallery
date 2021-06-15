//
//  APIRequestRouter.swift
//  ImageGallery
//
//  Created by Dmitry Smetankin on 15.06.2021.
//

import Alamofire

protocol APIRequestRouter {
    var path: String { get }
    var method: HTTPMethod { get }
    var parameters: Parameters? { get }
    var paramsEncoding: ParameterEncoding { get }
}

extension APIRequestRouter {
    var paramsEncoding: ParameterEncoding { return URLEncoding.default }
}
