//
//  AuthManagerProtocol.swift
//  Gallery
//
//  Created by Victor Sukochev on 14.08.2021.
//

import RxSwift

protocol AuthManagerProtocol {
    var isAuthorized: Observable<Bool> { get }
    
    func login(email: String, password: String)
}
