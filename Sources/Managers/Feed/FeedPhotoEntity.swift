//
//  FeedPhotoEntity.swift
//  Gallery
//
//  Created by Victor Sukochev on 15.08.2021.
//

import Foundation

struct FeedPhotoEntity {
    let id: String
    let thumbnails: [FeedThumbnailEntity]
}

// MARK: - JSON parsing

extension FeedPhotoEntity {
    static func parse(_ dict: [String: Any]) -> FeedPhotoEntity? {
        guard let id = dict["id"] as? String else { return nil }
        guard let thumbnailsArray = dict["thumbnail_urls"] as? [[String: Any]] else { return nil }
        
        let thumbnails = thumbnailsArray.compactMap({ FeedThumbnailEntity.parse($0) })
        
        return FeedPhotoEntity(id: id, thumbnails: thumbnails)
    }
}
