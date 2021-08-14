//
//  AuthManager.swift
//  Gallery
//
//  Created by Victor Sukochev on 14.08.2021.
//

import RxSwift

class AuthManager: AuthManagerProtocol {
    static let shared = AuthManager()
    
    private let apiService: ApiServiceProtocol
    
    private let disposeBag = DisposeBag()
    
    private init() {
        let container = InjectionContainer.container
        
        self.apiService = container.resolve(ApiServiceProtocol.self)!
    }
    
    var isAuthorized: Observable<Bool> {
        return self.apiService.isAuthorized
    }
    
    func login(email: String, password: String) {
        self.apiService.login(email: email, password: password).subscribe()
            .disposed(by: self.disposeBag)
    }
}
