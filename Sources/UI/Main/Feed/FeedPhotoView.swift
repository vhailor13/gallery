//
//  FeedPhotoView.swift
//  Gallery
//
//  Created by Victor Sukochev on 16.08.2021.
//

import SwiftUI
import struct Kingfisher.KFImage

struct FeedPhotoView<T: FeedPhotoViewModelProtocol>: View {
    
    init(_ viewModel: T) {
        self.viewModel = viewModel
    }
    
    @ObservedObject var viewModel: T
    
    var body: some View {
        KFImage(viewModel.url)
            .resizable()
            .aspectRatio(contentMode: .fill)
    }
}
