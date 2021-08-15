//
//  AuthManager.swift
//  Gallery
//
//  Created by Victor Sukochev on 14.08.2021.
//

import RxSwift

class AuthManager: AuthManagerProtocol {
    static let shared = AuthManager()
    
    var error: Observable<Error> {
        return self.errorSubject.asObservable()
    }
    
    var isInProgres: Observable<Bool> {
        return self.isInProgressSubject.asObservable()
    }
    
    private let apiService: ApiServiceProtocol
    
    private var errorSubject = PublishSubject<Error>()
    private var isInProgressSubject = PublishSubject<Bool>()
    private let disposeBag = DisposeBag()
    
    private init() {
        let container = InjectionContainer.container
        
        self.apiService = container.resolve(ApiServiceProtocol.self)!
    }
    
    var isAuthorized: Observable<Bool> {
        return self.apiService.isAuthorized
    }
    
    func login(email: String, password: String) {
        self.isInProgressSubject.on(.next(true))

        self.apiService.login(email: email, password: password).subscribe(onCompleted: { [unowned self] in
            self.isInProgressSubject.on(.next(false))
        }, onError: { [unowned self] error in
            self.isInProgressSubject.on(.next(false))
            self.errorSubject.on(.error(error))
        }).disposed(by: self.disposeBag)
    }
}
