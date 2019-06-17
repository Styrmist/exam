//
//  AlertMessage.swift
//  exam-bare
//
//  Created by Kirill on 6/17/19.
//  Copyright © 2019 Kirill. All rights reserved.
//

import Foundation

class AlertMessage: Error {
    
    var title = ""
    var body = ""
    
    init(title: String, body: String) {
        self.title = title
        self.body = body
    }
}
