//
//  PhotosLoaderManagerProtocol.swift
//  Gallery
//
//  Created by Victor Sukochev on 16.08.2021.
//

import RxSwift

protocol PhotosLoaderManagerProtocol {
    func cachedUrl(_ photoId: String) -> Observable<URL>
}
