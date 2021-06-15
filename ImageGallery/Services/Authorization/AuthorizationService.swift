//
//  AuthorizationService.swift
//  ImageGallery
//
//  Created by Dmitry Smetankin on 15.06.2021.
//

final class AuthorizationService {
    private let networkService: NetworkService
    
    init(networkService: NetworkService) {
        self.networkService = networkService
    }
    
    func authorize(completion: @escaping(Result<AuthorizationResponse, NetworkingError>) -> Void) {
        networkService.performRequest(
            request: AuthorizationRouter.authenticate(Constants.Authorization.apiKey),
            completionHandler: { (result: Result<AuthorizationResponse, NetworkingError>) in
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
