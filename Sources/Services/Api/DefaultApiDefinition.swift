//
//  DefaultApiDefinition.swift
//  Gallery
//
//  Created by Victor Sukochev on 14.08.2021.
//

import GraphQL_Swift

struct DefaultApiDefinition: GQLAPIDefinition {
    var authorization: GQLAuthorization?
    var rootRESTURLString: String = Config.apiUrlStr
    var rootWebsocketURLString: String = ""
}
