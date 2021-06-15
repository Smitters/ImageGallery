//
//  ImageGridViewController.swift
//  ImageGallery
//
//  Created by Dmitry Smetankin on 15.06.2021.
//

import UIKit

class ImageGridViewController: UIViewController, AlertShowable {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    lazy var imageGridViewPresenter = ImageGridViewPresenter(viewController: self)
    var images: [URL] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
        imageGridViewPresenter.handleScreenLoading()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    func dataUpdated(images: [URL]) {
        self.images = images
        collectionView.reloadData()
    }
}
