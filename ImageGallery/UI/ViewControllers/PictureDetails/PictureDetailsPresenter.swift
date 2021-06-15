//
//  PictureDetailsPresenter.swift
//  ImageGallery
//
//  Created by Dmitry Smetankin on 15.06.2021.
//

import UIKit

final class PictureDetailsPresenter {
    private lazy var interactor = PictureDetailsInteractor(presenter: self)
    private let selectedPicture: Picture
    private var fetchedPicture: DetailedPicture?
    private unowned let viewController: PictureDetailsViewController
    
    init(viewController: PictureDetailsViewController, selectedPicture: Picture) {
        self.viewController = viewController
        self.selectedPicture = selectedPicture
    }
    
    private func createViewModelForLoadingState(picture: Picture) -> PictureDetailsViewController.ViewModel {
        return PictureDetailsViewController.ViewModel(
            author: "Loading..",
            imageURL: URL(string: picture.croppedPicture),
            pictureDescription: "Loading.."
        )
    }
}

// MARK: UI Event Handlers

extension PictureDetailsPresenter {
    func handleScreenLoading() {
        interactor.fetchDetails(for: selectedPicture.id)
        
        let viewModel = createViewModelForLoadingState(picture: selectedPicture)
        viewController.configure(with: viewModel)
    }
    
    func handleError(message: String) {
        viewController.showAlert(title: "Ooops, Error occured", message: message)
    }
    
    func handleShare() {
        guard let detailedPicture = fetchedPicture,
              let url = URL(string: detailedPicture.fullPicture) else { return }
        
        let activityViewController = UIActivityViewController(activityItems: [url], applicationActivities: nil)
        viewController.present(activityViewController, animated: true)
    }
}

// MARK: Interactor Event Handlers

extension PictureDetailsPresenter {
    func handleDataLoading(_ response: DetailedPicture) {
        self.fetchedPicture = response
        let fullQualityURL = URL(string: response.fullPicture)
        let croppedImageURL = URL(string: response.croppedPicture)
        
        let description = response.camera + "\n" + response.tags
        
        let viewModel = PictureDetailsViewController.ViewModel(
            author: response.author,
            imageURL: fullQualityURL ?? croppedImageURL,
            pictureDescription: description
        )
        
        viewController.configure(with: viewModel)
    }
}
