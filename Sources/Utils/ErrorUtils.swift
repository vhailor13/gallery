//
//  ErrorUtils.swift
//  Gallery
//
//  Created by Victor Sukochev on 15.08.2021.
//

import Foundation

extension NSError {
    static func create(_ text: String, code: Int = 0, additionalInfo: [String: Any] = [:]) -> Error {
        var userInfo = additionalInfo
        userInfo[NSLocalizedDescriptionKey] = text
        
        return NSError(domain: "com.junehomes.ios", code: code, userInfo: userInfo)
    }
}
