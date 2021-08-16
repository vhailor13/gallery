//
//  MainViewModelProtocol.swift
//  Gallery
//
//  Created by Victor Sukochev on 14.08.2021.
//

import Combine

protocol MainViewModelProtocol: ObservableObject {
    var photos: [FeedPhotoEntity] { get }
    var error: Error? { get }
    var isErrorOccured: Bool { get set }
}
