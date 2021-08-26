//
//  FeedThumbnailEntity.swift
//  Gallery
//
//  Created by Victor Sukochev on 16.08.2021.
//

import Foundation

struct FeedThumbnailEntity {
    let width: Int
    let height: Int
    let url: URL
}

// MARK: - JSON parsing

extension FeedThumbnailEntity {
    static func create(ghqlEntity: PhotoFeedQuery.Data.Album.Photo.Record.ThumbnailUrl) -> FeedThumbnailEntity? {
        guard let urlStr = ghqlEntity.url, let url = URL(string: urlStr) else { return nil }
        guard let width = ghqlEntity.width else { return nil }
        guard let height = ghqlEntity.height else { return nil }
        
        return FeedThumbnailEntity(width: width, height: height, url: url)
    }
}
