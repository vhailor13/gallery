//
//  NetworkManagerProtocol.swift
//  Gallery
//
//  Created by Victor Sukochev on 15.08.2021.
//

import RxSwift

protocol NetworkManagerProtocol {
    var error: Observable<Error> { get }
    
    func fetch(_ query: String) -> Single<[String: Any]>
}
