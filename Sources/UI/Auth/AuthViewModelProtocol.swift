//
//  AuthViewModelProtocol.swift
//  Gallery
//
//  Created by Victor Sukochev on 14.08.2021.
//

import RxSwift
import SwiftUI

protocol AuthViewModelProtocol: ObservableObject {
    var email: Binding<String> { get }
    var password: Binding<String> { get }
    
    func signIn()
}
