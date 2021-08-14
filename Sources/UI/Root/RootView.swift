//
//  RootView.swift
//  Gallery
//
//  Created by Victor Sukochev on 14.08.2021.
//

import SwiftUI
import RxSwift

struct RootView<T: RootViewModelProtocol>: View {
    @ObservedObject var viewModel: T
    
    init(_ viewModel: T) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        if viewModel.isAuthorized {
            MainView(MainViewModel())
        } else {
            AuthView(AuthViewModel())
        }
    }
}
