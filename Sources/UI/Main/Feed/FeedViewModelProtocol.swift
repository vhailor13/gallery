//
//  FeedViewModelProtocol.swift
//  Gallery
//
//  Created by Victor Sukochev on 16.08.2021.
//

import Combine

protocol FeedViewModelProtocol: ObservableObject {
    var photos: [FeedPhotoEntity] { get }
}
