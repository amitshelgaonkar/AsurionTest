//
//  APIRequest.swift
//  AsurionTest
//
//  Created by amit on 27/08/22.
//

import Foundation

struct ConfigApiRequest: APIHandler {
    
    func makeRequest(from param: [String: Any]?) -> URLRequest? {
        let urlString =  APIPath.configAPI.urlPath()
        if let url = URL(string: urlString) {
            var urlRequest = URLRequest(url: url)
            setDefaultHeaders(request: &urlRequest)
            urlRequest.httpMethod = HTTPMethod.get.rawValue
            return urlRequest
        }
        return nil
    }
    
    func parseResponse(data: Data, response: HTTPURLResponse) throws -> ConfigModel {
        return try defaultParseResponse(data: data,response: response)
    }
}
