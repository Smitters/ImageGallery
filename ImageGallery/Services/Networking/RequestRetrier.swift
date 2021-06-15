//
//  RequestRetrier.swift
//  ImageGallery
//
//  Created by Dmitry Smetankin on 15.06.2021.
//

import Alamofire

final class RequestRetrier: RequestInterceptor {
    private lazy var networkService = Dependencies.current.services.networkService
    private lazy var authorizationService = Dependencies.current.services.authorizationService
    
    func retry(_ request: Request,
               for session: Session,
               dueTo error: Error,
               completion: @escaping (RetryResult) -> Void) {
        guard let afError = error.asAFError else {
            completion(.doNotRetryWithError(error))
            return
        }
        
        if afError.responseCode == 401 || afError.responseCode == 403 {
            authorizationService.authorize { [weak self] result in
                guard let self = self else { return }
                switch result {
                case .success(let response):
                    self.networkService.update(sessionId: response.token)
                    completion(.retry)
                case .failure(let error):
                    completion(.doNotRetryWithError(error))
                }
            }
        } else {
            completion(.doNotRetryWithError(error))
        }
    }
}
