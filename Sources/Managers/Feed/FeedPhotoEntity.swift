//
//  FeedPhotoEntity.swift
//  Gallery
//
//  Created by Victor Sukochev on 15.08.2021.
//

import Foundation
import Apollo

struct FeedPhotoEntity {
    let id: String
    let thumbnails: [FeedThumbnailEntity]
}

// MARK: - JSON parsing

extension FeedPhotoEntity {
    static func create(ghqlEntity: PhotoFeedQuery.Data.Album.Photo.Record) -> FeedPhotoEntity {
        let thumbnailsGhql = ghqlEntity.thumbnailUrls?.compactMap({ $0 }) ?? []
        
        return FeedPhotoEntity(id: ghqlEntity.id, thumbnails: thumbnailsGhql.compactMap({ FeedThumbnailEntity.create(ghqlEntity: $0) }) )
    }
}
