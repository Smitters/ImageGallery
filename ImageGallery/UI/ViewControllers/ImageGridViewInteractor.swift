//
//  ImageGridViewInteractor.swift
//  ImageGallery
//
//  Created by Dmitry Smetankin on 15.06.2021.
//

import Foundation

class ImageGridViewInteractor {
    private let dataFetchingService: DataFetchingService
    private let authorizationService: AuthorizationService
    private let networkService: NetworkService
    
    weak var presenter: ImageGridViewPresenter?
    
    var currentPage = 0
    var totalPages = 0
    var hasMore = true
    var pictures: [Picture] = []
    
    init(dataFetchingService: DataFetchingService = Dependencies.current.services.dataFetchingService,
         authorizationService: AuthorizationService = Dependencies.current.services.authorizationService,
         networkService: NetworkService = Dependencies.current.services.networkService) {
        
        self.dataFetchingService = dataFetchingService
        self.authorizationService = authorizationService
        self.networkService = networkService
    }
    
    func authorizeAndFetchInitialData() {
        authorizationService.authorize { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let response):
                self.updateAuthorizationToken(token: response.token)
                self.fetchMoreImages()
            case .failure(let error):
                self.presenter?.handleError(message: error.localizedDescription)
            }
        }
    }
    
    func fetchMoreImages() {
        guard hasMore else { return }
        
        dataFetchingService.fetchImages(page: currentPage) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let response):
                self.handlePictureResponse(response)
            case .failure(let error):
                self.presenter?.handleError(message: error.localizedDescription)
            }
        }
    }
    
    private func updateAuthorizationToken(token: String) {
        networkService.update(sessionId: token)
    }
    
    private func handlePictureResponse(_ response: FetchImagesResponse) {
        currentPage = response.page + 1
        totalPages = response.pageCount
        hasMore = response.hasMore
        pictures.append(contentsOf: response.pictures)
        presenter?.handleNewPictures(pictures)
    }
}
