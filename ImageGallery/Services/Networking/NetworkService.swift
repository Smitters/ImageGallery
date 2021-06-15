//
//  NetworkService.swift
//  ImageGallery
//
//  Created by Dmitry Smetankin on 15.06.2021.
//

import Alamofire
import Foundation

final class NetworkService {
    private var sessionId: String?
    private let baseURL: String
    private let session: Session
    
    init(baseURL: String, sessionId: String? = nil) {
        self.baseURL = baseURL
        self.sessionId = sessionId
        session = Session(configuration: .default)
    }
    
    func update(sessionId: String?) {
        self.sessionId = sessionId
    }
    
    func performRequest<ResponseType: Decodable>(
        request: APIRequestRouter,
        retrier: RequestRetrier? = RequestRetrier(),
        completionHandler: @escaping (Result<ResponseType, NetworkingError>) -> Void) {
        
        guard let baseURL = URL(string: baseURL) else {
            completionHandler(.failure(.noURL))
            return
        }
        
        session.request(baseURL.appendingPathComponent(request.path),
                        method: request.method,
                        parameters: request.parameters,
                        encoding: request.paramsEncoding,
                        headers: createHeaders(),
                        interceptor: retrier)
            .validate()
            .responseDecodable(of: ResponseType.self) { response in
                if let error = response.error?.underlyingError as? NetworkingError {
                    completionHandler(.failure(error))
                } else if let afError = response.error {
                    completionHandler(.failure(NetworkingError.fromAlamofire(afError)))
                } else if let decoded = response.value {
                    completionHandler(.success(decoded))
                } else {
                    completionHandler(.failure(NetworkingError.dataFailedToDecode))
                }
            }
    }
    
    private func createHeaders() -> HTTPHeaders {
        var defaultHeaders = HTTPHeaders.default
        guard let bearerToken = self.sessionId else { return defaultHeaders }
        
        let token = HTTPHeader(name: "Authorization", value: "Bearer \(bearerToken)")
        defaultHeaders.add(token)
        
        return defaultHeaders
    }
}

enum NetworkingError: LocalizedError {
    case noURL
    case dataFailedToDecode
    case fromServer(code: Int, message: String)
    case fromAlamofire(AFError)

    var errorDescription: String? {
        switch self {
        case .fromServer(code: _, message: let message): return message
        case .fromAlamofire(let afError): return afError.localizedDescription
        case .dataFailedToDecode: return "Failed to decode data."
        case .noURL: return "No URL provided."
        }
    }
}
