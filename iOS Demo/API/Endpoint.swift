//
//  Endpoint.swift
//  iOS Demo
//
//  Created by Mo Moosa on 15/05/2022.
//

import Foundation

struct Endpoint<Response: Decodable> {
    var path: String
    var method = HTTPMethod.get
    var authenticated = true
    var queryItems = [URLQueryItem]()
}

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
}
