//
//  AuthViewModel.swift
//  Gallery
//
//  Created by Victor Sukochev on 14.08.2021.
//

import SwiftUI
import RxSwift
import Combine

class AuthViewModel: AuthViewModelProtocol {
//    @Published var email: String = ""
//    @Published  var password: String = ""
    
    @Published var email: String = "thanos+ios+engineer@waldophotos.com"
    @Published  var password: String = "!!waldo123_"
    
    @Published private(set) var error: Error? = nil
    @Published var isErrorOccured: Bool = false
    @Published var isInProgress: Bool = false
    
    private let authManager: AuthManagerProtocol
    
    private let disposeBag = DisposeBag()
    private var cancellable: AnyCancellable?
    
    init() {
        let container = InjectionContainer.container
        
        self.authManager = container.resolve(AuthManagerProtocol.self)!
        
        self.setupBindings()
    }
    
    func signIn() {
        self.authManager.login(email: self.email, password: self.password)
    }
    
    // MARK: -
    
    private func setupBindings() {
        self.authManager.error.observe(on: MainScheduler.instance).subscribe(onError: { [weak self] error in
            self?.error = error
            self?.isErrorOccured = true
        }).disposed(by: self.disposeBag)
        
        self.authManager.isInProgres.observe(on: MainScheduler.instance).subscribe(onNext: { [weak self] state in
            self?.isInProgress = state
        }).disposed(by: self.disposeBag)
    }
}
