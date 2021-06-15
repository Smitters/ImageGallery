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
    private unowned let presenter: ImageGridViewPresenter
    
    private var currentPage = 0
    private var totalPages = 0
    private var hasMore = true
    private var loadingInProgress = false
    private var pictures: [Picture] = []
    
    init(dataFetchingService: DataFetchingService = Dependencies.current.services.dataFetchingService,
         authorizationService: AuthorizationService = Dependencies.current.services.authorizationService,
         networkService: NetworkService = Dependencies.current.services.networkService,
         presenter: ImageGridViewPresenter) {
        
        self.dataFetchingService = dataFetchingService
        self.authorizationService = authorizationService
        self.networkService = networkService
        self.presenter = presenter
    }
    
    func authorizeAndFetchInitialData() {
        authorizationService.authorize { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let response):
                self.updateAuthorizationToken(token: response.token)
                self.fetchMoreImages()
            case .failure(let error):
                self.presenter.handleError(message: error.localizedDescription)
            }
        }
    }
    
    func fetchMoreImages() {
        guard hasMore, !loadingInProgress else { return }
        loadingInProgress = true
        
        dataFetchingService.fetchImages(page: currentPage) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let response):
                self.handlePictureResponse(response)
            case .failure(let error):
                self.presenter.handleError(message: error.localizedDescription)
            }
        }
    }
    
    func getPicture(at index: Int) -> Picture {
        return pictures[index]
    }
    
    private func updateAuthorizationToken(token: String) {
        networkService.update(sessionId: token)
    }
    
    private func handlePictureResponse(_ response: FetchImagesResponse) {
        loadingInProgress = false
        currentPage = response.page + 1
        totalPages = response.pageCount
        hasMore = response.hasMore
        pictures.append(contentsOf: response.pictures)
        presenter.handleNewPictures(pictures)
    }
}
