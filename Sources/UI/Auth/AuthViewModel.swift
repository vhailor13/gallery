//
//  AuthViewModel.swift
//  Gallery
//
//  Created by Victor Sukochev on 14.08.2021.
//

import SwiftUI
import RxSwift

class AuthViewModel: AuthViewModelProtocol {
    var email: Binding<String> = Binding<String>.constant("")
    var password: Binding<String> = Binding<String>.constant("")
    
    private let authManager: AuthManagerProtocol
    
    private let disposeBag = DisposeBag()
    
    init() {
        let container = InjectionContainer.container
        
        self.authManager = container.resolve(AuthManagerProtocol.self)!
    }
    
    func signIn() {
        self.authManager.login(email: self.email.wrappedValue, password: self.password.wrappedValue)
    }
}
