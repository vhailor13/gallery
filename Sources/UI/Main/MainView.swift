//
//  MainView.swift
//  Gallery
//
//  Created by Victor Sukochev on 14.08.2021.
//

import SwiftUI

struct MainView<T: MainViewModelProtocol>: View {
    
    init(_ viewModel: T) {
        self.viewModel = viewModel
    }
    
    @ObservedObject var viewModel: T
    
    var body: some View {
        VStack {
            FeedView(FeedViewModel())
        }.alert(isPresented: $viewModel.isErrorOccured) {
            Alert(
                title: Text("Error"),
                message: Text(viewModel.error?.localizedDescription ?? ""),
                dismissButton: .default(Text("OK")))
        }
    }
    
}
