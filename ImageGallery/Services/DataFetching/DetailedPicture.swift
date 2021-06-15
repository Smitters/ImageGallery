//
//  PictureDetailsResponse.swift
//  ImageGallery
//
//  Created by Dmitry Smetankin on 15.06.2021.
//

struct DetailedPicture: Codable {
    let id: String
    let author: String
    let fullPicture: String
    let croppedPicture: String
    let camera: String
    let tags: String
    
    enum CodingKeys: String, CodingKey {
        case id, author, camera, tags
        case croppedPicture = "cropped_picture"
        case fullPicture = "full_picture"
    }
}
