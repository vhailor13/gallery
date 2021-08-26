//
//  NetworkManagerProtocol.swift
//  Gallery
//
//  Created by Victor Sukochev on 15.08.2021.
//

import RxSwift
import Apollo

protocol NetworkManagerProtocol {
    var error: Observable<Error> { get }
    
    func fetch<Query: GraphQLQuery>(_ query: Query) -> Single<Query.Data?>
}
