//
//  NetworkManager.swift
//  Gallery
//
//  Created by Victor Sukochev on 15.08.2021.
//

import RxSwift

class NetworkManager: NetworkManagerProtocol {
    static let shared = NetworkManager()
    
    var error: Observable<Error> {
        return self.errorSubject.asObservable()
    }
    
    private var errorSubject = PublishSubject<Error>()
    
    private let apiService: ApiServiceProtocol
    
    private init() {
        let container = InjectionContainer.container
        
        self.apiService = container.resolve(ApiServiceProtocol.self)!
    }
    
    func fetch(_ query: String) -> Single<[String: Any]> {
        return self.apiService.fetch(query).do(onError: { [unowned self] error in
            self.errorSubject.on(.next(error))
        })
    }
}
