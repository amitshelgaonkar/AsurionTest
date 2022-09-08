//
//  RequestHandlerExtension.swift
//  AsurionTest
//
//  Created by amit on 27/08/22.
//

import Foundation

// API Headers
struct APIHeaders {
    static var kContentType = "Content-Type"
    static var contentTypeValue = "application/json"
}

// MARK: Request Handler Supporting methods

extension RequestHandler {
    
    func setDefaultHeaders(request: inout URLRequest) {
        request.setValue(APIHeaders.contentTypeValue, forHTTPHeaderField: APIHeaders.kContentType)
    }
}
