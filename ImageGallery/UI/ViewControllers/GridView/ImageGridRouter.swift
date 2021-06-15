//
//  ImageGridRouter.swift
//  ImageGallery
//
//  Created by Dmitry Smetankin on 15.06.2021.
//

import UIKit

final class ImageGridRouter {
    unowned let navigationController: UINavigationController?
    
    init(navigationController: UINavigationController?) {
        self.navigationController = navigationController
    }
    
    func showDetailsScreen(with picture: Picture) {
        let mainStoryBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let identifier = String(describing: PictureDetailsViewController.self)
        guard let detailsViewController = mainStoryBoard
                .instantiateViewController(withIdentifier: identifier) as? PictureDetailsViewController else {
            return
        }
        let detailsPresenter = PictureDetailsPresenter(viewController: detailsViewController, selectedPicture: picture)
        detailsViewController.presenter = detailsPresenter
        navigationController?.pushViewController(detailsViewController, animated: true)
    }
}
