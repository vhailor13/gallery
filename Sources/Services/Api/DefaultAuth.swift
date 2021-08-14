//
//  DefaultAuth.swift
//  Gallery
//
//  Created by Victor Sukochev on 14.08.2021.
//

import GraphQL_Swift

struct DefaultAuth: GQLAuthorization {
    var clientID: String?
    var apiKey: String?
    var authorizationHeader: [String : String] = [:]
    var jwt: String? = nil
}
