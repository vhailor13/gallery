//
//  AuthViewModelProtocol.swift
//  Gallery
//
//  Created by Victor Sukochev on 14.08.2021.
//

import RxSwift
import SwiftUI

protocol AuthViewModelProtocol: ObservableObject {
    var email: String { get set }
    var password: String { get set }
    
    var error: Error? { get }
    var isErrorOccured: Bool { get set }
    var isInProgress: Bool { get }
    
    func signIn()
}
