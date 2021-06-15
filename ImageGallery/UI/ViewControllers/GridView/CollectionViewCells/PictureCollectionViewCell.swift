//
//  PictureCollectionViewCell.swift
//  ImageGallery
//
//  Created by Dmitry Smetankin on 15.06.2021.
//

import UIKit
import Kingfisher

final class PictureCollectionViewCell: UICollectionViewCell {
    static let reuseIdentifier: String = String(describing: PictureCollectionViewCell.self)

    @IBOutlet weak var imageView: UIImageView!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.kf.cancelDownloadTask()
        imageView.image = nil
    }
    
    func configure(with url: URL) {
        imageView.kf.setImage(with: url)
    }
}
