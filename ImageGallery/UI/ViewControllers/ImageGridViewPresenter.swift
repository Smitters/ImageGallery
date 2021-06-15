//
//  ImageGridViewPresenter.swift
//  ImageGallery
//
//  Created by Dmitry Smetankin on 15.06.2021.
//

import Foundation

class ImageGridViewPresenter {
    private let interactor: ImageGridViewInteractor
    private unowned let viewController: ImageGridViewController
    
    init(viewController: ImageGridViewController) {
        self.viewController = viewController
        interactor = ImageGridViewInteractor()
        interactor.presenter = self
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
