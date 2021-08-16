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
    static func parse(_ dict: [String: Any]) -> FeedThumbnailEntity? {
        guard let urlStr = dict["url"] as? String else { return nil }
        guard let url = URL(string: urlStr) else { return nil}
        guard let width = dict["width"] as? Int else { return nil }
        guard let height = dict["height"] as? Int else { return nil }
        
        return FeedThumbnailEntity(width: width, height: height, url: url)
    }
}
