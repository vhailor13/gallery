//
//  FeedView.swift
//  Gallery
//
//  Created by Victor Sukochev on 16.08.2021.
//

import SwiftUI

struct FeedView<T: FeedViewModelProtocol>: View {
    
    init(_ viewModel: T) {
        self.viewModel = viewModel
    }
    
    @ObservedObject var viewModel: T
    
    var body: some View {
        List {
            ForEach(viewModel.photos, id: \.self.id) {
                FeedPhotoView(FeedPhotoViewModel($0.id))
            }
        }
    }
}
