//
//  FeedPhotoViewModelProtocol.swift
//  Gallery
//
//  Created by Victor Sukochev on 16.08.2021.
//

import Foundation

protocol FeedPhotoViewModelProtocol: ObservableObject {
    var url: URL? { get }
}
