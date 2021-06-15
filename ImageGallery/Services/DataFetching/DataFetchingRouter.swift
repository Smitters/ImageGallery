//
//  DataFetchingRouter.swift
//  ImageGallery
//
//  Created by Dmitry Smetankin on 15.06.2021.
//

import Alamofire

enum DataFetchingRouter: APIRequestRouter {
    // MARK: - Endpoints

    case images(Int)
    case imageDetails(String)

    // MARK: - Routing

    var path: String {
        switch self {
        case .images, .image: return "images"
        }
    }

    var method: HTTPMethod {
        switch self {
        case .imageDetails, .images: return .get
        }
    }

    var parameters: Parameters? {
        switch self {
        case .images(let page):
            return ["page": page]
        case .imageDetails(let imageId):
            return ["id": imageId]

        }
    }
}
