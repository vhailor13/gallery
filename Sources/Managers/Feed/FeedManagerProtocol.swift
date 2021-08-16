//
//  FeedManagerProtocol.swift
//  Gallery
//
//  Created by Victor Sukochev on 15.08.2021.
//

import RxSwift

protocol FeedManagerProtocol {
    var photos: Observable<[FeedPhotoEntity]> { get }
    
    func fetchNext()
    func photo(_ id: String) -> FeedPhotoEntity?
}
