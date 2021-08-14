//
//  ApiServiceProtocol.swift
//  Gallery
//
//  Created by Victor Sukochev on 14.08.2021.
//

import RxSwift

protocol ApiServiceProtocol {
    var isAuthorized: Observable<Bool> { get }
    
    func login(email: String, password: String) -> Completable
    func fetch(_ query: String) -> Single<[String: Any]>
}
