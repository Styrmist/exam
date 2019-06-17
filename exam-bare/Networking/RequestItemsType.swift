//
//  RequestItemsType.swift
//  exam-bare
//
//  Created by Kirill on 6/17/19.
//  Copyright © 2019 Kirill. All rights reserved.
//

import Foundation
import Alamofire

enum RequestItemsType {
    
    case searchByRegion(query: String)
    case searchByBlock(query: String)
    case searchByFullName(query: String)
    case searchByCode(query: String)
    case search(query: String)
}

extension RequestItemsType: EndPointType {
    
    var baseURL: String {
        return "https://restcountries.eu/rest"
    }
    
    var version: String {
        return "/v2"
    }
    
    var path: String {
        switch self {
        case .search(let query):
            return "/name/\(query)"
        case .searchByBlock(let query):
            return "/regionalbloc/\(query)"
        case .searchByRegion(let query):
            return "region/\(query)"
        case .searchByFullName(let query):
            return "/name/\(query)?fullText=true"
        case .searchByCode(let query):
            return "/alpha/\(query)"
        }
    }
    
    var httpMethod: HTTPMethod {
        return .get
    }
    
    var headers: HTTPHeaders? {
        return ["Content-Type": "application/json"]
    }
    
    var url: URL {
        return URL(string: self.baseURL + self.version + self.path)!
    }
    
    var encoding: ParameterEncoding {
        return JSONEncoding.default
    }
}
