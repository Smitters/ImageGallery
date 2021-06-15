//
//  ImageGridViewController.swift
//  ImageGallery
//
//  Created by Dmitry Smetankin on 15.06.2021.
//

import UIKit

class ImageGridViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    lazy var imageGridViewPresenter = ImageGridViewPresenter(viewController: self)
    var images: [URL] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
        imageGridViewPresenter.handleScreenLoading()
    }
    
    func showAlert(title: String, message: String) {
        let alertViewController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertViewController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alertViewController, animated: true)
    }
    
    func dataUpdated(images: [URL]) {
        self.images = images
        collectionView.reloadData()
    }
}
