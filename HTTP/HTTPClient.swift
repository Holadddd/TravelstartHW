//
//  HTTPClient.swift
//  TravelstartHW
//
//  Created by ting hui wu on 2019/11/1.
//  Copyright © 2019 ting hui wu. All rights reserved.
//

import Foundation

enum TSHTTPClientError: Error {

    case decodeDataFail

    case clientError(Data)

    case serverError

    case unexpectedError
}

enum TSHTTPMethod: String {

    case GET

    case POST
}

enum TSHTTPHeaderField: String {

    case contentType = "Content-Type"

    case auth = "Authorization"
}

enum TSHTTPHeaderValue: String {

    case json = "application/json"
}

protocol TSRequest {

    var headers: [String: String] { get }

    var body: Data? { get }

    var method: String { get }

    var endPoint: String { get }
}

class HTTPClient {

    static let shared = HTTPClient()

    private let decoder = JSONDecoder()

    private let encoder = JSONEncoder()

    private init() { }
    
    func request(
        _ stRequest: TSRequest,
        completion: @escaping (Result<Data, Error>) -> Void
    ) {

        URLSession.shared.dataTask(
            with: makeRequest(stRequest),
            completionHandler: { (data, response, error) in

            guard error == nil else {

                return completion(Result.failure(error!))
            }
                
            // swiftlint:disable force_cast
            let httpResponse = response as! HTTPURLResponse
            // swiftlint:enable force_cast
            let statusCode = httpResponse.statusCode

            switch statusCode {

            case 200..<300:

                completion(Result.success(data!))

            case 400..<500:

                completion(Result.failure(TSHTTPClientError.clientError(data!)))

            case 500..<600:

                completion(Result.failure(TSHTTPClientError.serverError))

            default: return

                completion(Result.failure(TSHTTPClientError.unexpectedError))
            }

        }).resume()
    }

    private func makeRequest(_ tsRequest: TSRequest) -> URLRequest {

        let urlString = Bundle.TSValueForString(key: TSConstant.taipeiOpenAPI) + tsRequest.endPoint

        let url = URL(string: urlString)!

        var request = URLRequest(url: url)

        request.allHTTPHeaderFields = tsRequest.headers
        
        request.httpBody = tsRequest.body

        request.httpMethod = tsRequest.method

        return request
    }
}
