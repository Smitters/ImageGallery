//
//  ImageGridViewPresenter.swift
//  ImageGallery
//
//  Created by Dmitry Smetankin on 15.06.2021.
//

import UIKit

class ImageGridViewPresenter {
    private let router: ImageGridRouter
    private lazy var interactor = ImageGridViewInteractor(presenter: self)
    private unowned let viewController: ImageGridViewController
    
    init(viewController: ImageGridViewController) {
        self.viewController = viewController
        router = ImageGridRouter(navigationController: viewController.navigationController)
    }
}

// MARK: UI Event Handlers

extension ImageGridViewPresenter {
    func handleScreenLoading() {
        interactor.authorizeAndFetchInitialData()
    }
    
    func handleLatestCellsDisplaying() {
        interactor.fetchMoreImages()
    }
    
    func handlePictureSelection(at index: Int) {
        let selectedPicture = interactor.getPicture(at: index)
        router.showDetailsScreen(with: selectedPicture)
    }
}

// MARK: Interactor Event Handlers

extension ImageGridViewPresenter {
    func handleError(message: String) {
        viewController.showAlert(title: "Ooops, Error occured", message: message)
    }
    
    func handleNewPictures(_ pictures: [Picture]) {
        viewController.dataUpdated(images: pictures.compactMap { URL(string: $0.croppedPicture) })
    }
}
