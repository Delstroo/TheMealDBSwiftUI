//
//  NetworkingLayer.swift
//  MealSwiftUI
//
//  Created by Delstun McCray on 8/21/23.
//

import Foundation

struct Constants {
    static let baseURL = "https://www.themealdb.com/api/json/v1/1/"
}

enum HTTPMethod: String {
    case get = "GET"
    case post = "POSTS"
    case put = "PUT"
    case delete = "DELETE"
    case patch = "PATCH"
}

protocol APIRequest {
    var url: String? {get}
    var path: String {get}
    var method: HTTPMethod {get}
    var queryItems: [URLQueryItem]? {get}
    var params: Any? {get}
    var timeoutInterval: TimeInterval {get}
}
extension APIRequest {
    var url: String? {nil}
    var queryItems: [URLQueryItem]? {[]}
    var params: Any? {nil}
    var timeoutInterval: TimeInterval {10.0}
}

enum NetworkError: Error {
    case general(Error)
    case status(Int)
    case dataInvalid
    case dataError(Error)
    case httpError
    
    var description: String {
        switch self {
            
        case .general(let error):
            return "There was an error \(error)"
        case .status(let status):
            return "You status code is: \(status)"
        case .dataInvalid:
            return "Invalid data check your url"
        case .dataError(let error):
            return "There has been an error \(error)"
        case .httpError:
            return "The Http you enter is incorrect"
        }
    }
}

struct NetworkRequest {
    var request: URLRequest
    
    init(apiRequest: APIRequest) {
        var urlcomponents = URLComponents(string: apiRequest.url?.description ?? Constants.baseURL) // if there is nothing inside api.url than send me the base url
        
        let path = urlcomponents?.path.appending(apiRequest.path) ?? ""
        
        urlcomponents?.path = path
        
        if let queryItem = apiRequest.queryItems {
            urlcomponents?.queryItems =  queryItem
        }
        guard let fullUrl = urlcomponents?.url else {
            assertionFailure("Did not load the url")
            request = URLRequest(url: URL(string: "")!)
            return
        }
        request = URLRequest(url: fullUrl)
        request.httpMethod = apiRequest.method.rawValue
        request.timeoutInterval = apiRequest.timeoutInterval
    }
}
