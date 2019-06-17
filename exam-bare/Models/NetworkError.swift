//
//  NetworkError.swift
//  exam-bare
//
//  Created by Kirill on 6/17/19.
//  Copyright © 2019 Kirill. All rights reserved.
//

import Foundation

class NetworkError: Codable {
    
    let message: String
    let key: String?
}
