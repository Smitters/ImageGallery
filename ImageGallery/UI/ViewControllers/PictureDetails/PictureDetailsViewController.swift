//
//  PictureDetailsViewController.swift
//  ImageGallery
//
//  Created by Dmitry Smetankin on 15.06.2021.
//

import UIKit
import Kingfisher

final class PictureDetailsViewController: UIViewController, AlertShowable {
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var authorNameLabel: UILabel!
    @IBOutlet weak var pictureDescriptionLabel: UILabel!
    
    var presenter: PictureDetailsPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.delegate = self
        scrollView.maximumZoomScale = 5
        scrollView.minimumZoomScale = 1
        presenter.handleScreenLoading()
    }
    
    func configure(with viewModel: ViewModel) {
        imageView.kf.setImage(with: viewModel.imageURL)
        authorNameLabel.text = viewModel.author
        pictureDescriptionLabel.text = viewModel.pictureDescription
    }
}

extension PictureDetailsViewController: UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
}

extension PictureDetailsViewController {
    struct ViewModel {
        let author: String
        let imageURL: URL?
        let pictureDescription: String
    }
}
