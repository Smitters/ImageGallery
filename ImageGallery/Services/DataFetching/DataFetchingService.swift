//
//  DataFetchingService.swift
//  ImageGallery
//
//  Created by Dmitry Smetankin on 15.06.2021.
//

final class DataFetchingService {
    private let networkService: NetworkService
    
    init(networkService: NetworkService) {
        self.networkService = networkService
    }
    
    func fetchImages(page: Int = 0, completion: @escaping(Result<FetchImagesResponse, NetworkingError>) -> Void) {
        networkService.performRequest(
            request: DataFetchingRouter.images(page),
            completionHandler: { (result: Result<FetchImagesResponse, NetworkingError>) in
                switch result {
                case .failure(let error):
                    completion(.failure(error))
                case .success(let response):
                    completion(.success(response))
                }
            }
        )
    }
    
    func fetchImageDetails(id: String, completion: @escaping(Result<PictureDetailsResponse, NetworkingError>) -> Void) {
        networkService.performRequest(
            request: DataFetchingRouter.imageDetails(id),
            completionHandler: { (result: Result<PictureDetailsResponse, NetworkingError>) in
                switch result {
                case .failure(let error):
                    completion(.failure(error))
                case .success(let response):
                    completion(.success(response))
                }
            }
        )
    }
}
