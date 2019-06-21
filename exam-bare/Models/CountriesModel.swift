//
//  CountriesModel.swift
//  exam-bare
//
//  Created by Kirill on 6/17/19.
//  Copyright © 2019 Kirill. All rights reserved.
//

import Foundation

enum CountriesModel {
    
    struct Country: Codable {
        let name: String
        let latlng: [Double]
        let borders: [String] //alpha 3 codes
        let area: Double?
        let nativeName: String
        let alpha2Code: String
        let currencies: [Currency]
        let languages: [Language]
    }
    
    struct Currency: Codable {
        let code: String?
        let name: String?
        let symbol: String?
    }
    
    struct Language: Codable {
        let name: String?
        let nativeName: String?
    }
}
