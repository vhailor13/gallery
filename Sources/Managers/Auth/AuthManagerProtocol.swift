//
//  AuthManagerProtocol.swift
//  Gallery
//
//  Created by Victor Sukochev on 14.08.2021.
//

import RxSwift

protocol AuthManagerProtocol {
    var isAuthorized: Observable<Bool> { get }
    var isInProgres: Observable<Bool> { get }
    var error: Observable<Error> { get }
    
    func login(email: String, password: String)
}
