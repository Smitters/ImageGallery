//
//  PictureDetailsInteractor.swift
//  ImageGallery
//
//  Created by Dmitry Smetankin on 15.06.2021.
//

import Foundation

final class PictureDetailsInteractor {
    private let dataFetchingService: DataFetchingService
    unowned let presenter: PictureDetailsPresenter
    
    init(dataFetchingService: DataFetchingService = Dependencies.current.services.dataFetchingService,
         presenter: PictureDetailsPresenter) {
        self.dataFetchingService = dataFetchingService
        self.presenter = presenter
    }
    
    func fetchDetails(for pictureId: String) {
        dataFetchingService.fetchImageDetails(id: pictureId) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let response):
                self.presenter.handleDataLoading(response)
            case .failure(let error):
                self.presenter.handleError(message: error.localizedDescription)
            }
        }
    }
}
