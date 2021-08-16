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
            ForEach(viewModel.photos, id: \.self.id) { photo in
                FeedPhotoView(FeedPhotoViewModel(photo.id))
                    .onAppear(perform: {
                        // Using simple criteria for nextPage fetching
                        
                        guard let lastId = viewModel.photos.last?.id else { return }
                        guard lastId == photo.id else { return }
                        
                        viewModel.fetchNext()
                    })
                    //.frame(height: 88.0)
            }
        }
    }
}
