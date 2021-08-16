//
//  PhotosLoaderManager.swift
//  Gallery
//
//  Created by Victor Sukochev on 16.08.2021.
//

import RxSwift

class PhotosLoaderManager: PhotosLoaderManagerProtocol {
    static let shared = PhotosLoaderManager()
    
    private let feedManager: FeedManagerProtocol
    
    private init() {
        let container = InjectionContainer.container
        self.feedManager = container.resolve(FeedManagerProtocol.self)!
    }
    
    func cachedUrl(_ photoId: String) -> Observable<URL> {
        // Currently do not have enough time for proper low-resolution thumbnails utilization
        // So let's  just use the photo with the highest resolution and utilize Kingsfisher's cache
        
        guard let url = self.feedManager.photo(photoId)?.thumbnails.last?.url else {
            return .error(NSError.create("No cached photo with id \(photoId)"))
        }
        
        return .just(url)
    }
}
