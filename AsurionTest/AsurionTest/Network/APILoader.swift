//
//  APILoader.swift
//  AsurionTest
//
//  Created by amit on 27/08/22.
//

import Foundation

enum APIPath {
    case configAPI
    case petAPI
    
    func urlPath() -> String {
        switch self {
        case .configAPI:
            return "https://api.npoint.io/f00725fed10eadfc95c5"
        case .petAPI:
            return "https://api.npoint.io/b59fc7df386ce58bc986"
            
        }
    }
}

struct APILoader<T: APIHandler> {
    var apiHandler: T
    var urlSession: URLSession
    
    init(apiHandler: T, urlSession: URLSession = .shared) {
        self.apiHandler = apiHandler
        self.urlSession = urlSession
    }
    
    func loadAPIRequest(requestData: T.RequestDataType?, completionHandler: @escaping (T.ResponseDataType?, ServiceError?) -> ()) {
        if let urlRequest = apiHandler.makeRequest(from: requestData) {
            urlSession.dataTask(with: urlRequest) { (data, response, error) in
                
                if let httpResponse = response as? HTTPURLResponse {
                    
                    guard error == nil else {
                        completionHandler(nil, ServiceError(httpStatus: httpResponse.statusCode, message: "ServiceError : \(error?.localizedDescription ?? "Unknown Error")"))
                        return
                    }
                    
                    guard let responseData = data else {
                        completionHandler(nil, ServiceError(httpStatus: httpResponse.statusCode, message: "ServiceError : \(error?.localizedDescription ?? "Unknown Error")"))
                        return
                    }
                    
                    do {
                        let parsedResponse = try self.apiHandler.parseResponse(data: responseData, response: httpResponse)
                        completionHandler(parsedResponse, nil)
                    } catch {
                        completionHandler(nil, ServiceError(httpStatus:  httpResponse.statusCode, message: "ServiceError : \(error.localizedDescription)"))
                    }
                    
                }
                
                
            }.resume()
        }
    }
}
