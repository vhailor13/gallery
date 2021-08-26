//
//  ApiServiceProtocol.swift
//  Gallery
//
//  Created by Victor Sukochev on 14.08.2021.
//

import RxSwift
import Apollo

protocol ApiServiceProtocol {
    var isAuthorized: Observable<Bool> { get }
    
    func login(email: String, password: String) -> Completable
    func fetch<Query: GraphQLQuery>(_ query: Query) -> Single<Query.Data?>
}
