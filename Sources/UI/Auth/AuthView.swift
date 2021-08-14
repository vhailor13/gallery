//
//  AuthView.swift
//  Gallery
//
//  Created by Victor Sukochev on 14.08.2021.
//

import SwiftUI

struct AuthView<T: AuthViewModelProtocol>: View {
    init(_ viewModel: T) {
        self.viewModel = viewModel
    }
    
    @ObservedObject var viewModel: T
    
    var body: some View {
        Text("Auth")
    }
}
