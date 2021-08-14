//
//  DefaultQuery.swift
//  Gallery
//
//  Created by Victor Sukochev on 14.08.2021.
//

import GraphQL_Swift

struct DefaultQuery: GQLQuery {
    var graphQLLiteral: String = ""
    var variables: [String : Any]?
    var fragments: [GQLFragment]?
    
    init(_ query: String) {
        self.graphQLLiteral = query
    }
}
