//
//  RootViewModelProtocol.swift
//  Gallery
//
//  Created by Victor Sukochev on 14.08.2021.
//

import Combine

protocol RootViewModelProtocol: ObservableObject {
    var isAuthorized: Bool { get }
}
