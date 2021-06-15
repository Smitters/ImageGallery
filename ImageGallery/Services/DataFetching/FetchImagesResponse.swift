//
//  FetchImagesResponse.swift
//  ImageGallery
//
//  Created by Dmitry Smetankin on 15.06.2021.
//

import Foundation

struct FetchImagesResponse: Codable {
    let pictures: [Picture]
    let page: Int
    let pageCount: Int
    let hasMore: Bool
}

struct Picture: Codable {
    let id: String
    let croppedPicture: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case croppedPicture = "cropped_picture"
    }
}
