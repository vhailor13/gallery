//
//  FeedPhotoViewModel.swift
//  Gallery
//
//  Created by Victor Sukochev on 16.08.2021.
//

import Combine
import RxSwift

class FeedPhotoViewModel: FeedPhotoViewModelProtocol {
    @Published var url: URL? = nil
    
    private let photosLoaderManager: PhotosLoaderManagerProtocol
    
    private let photoId: String
    private let disposeBag = DisposeBag()
    
    init(_ photoId: String) {
        let container = InjectionContainer.container
        self.photosLoaderManager = container.resolve(PhotosLoaderManagerProtocol.self)!
        
        self.photoId = photoId
        
        self.setupBindings()
    }
    
    // MARK: -
    
    private func setupBindings() {
        self.photosLoaderManager.cachedUrl(self.photoId).observe(on: MainScheduler.instance).subscribe(onNext: { [weak self] url in
            self?.url = url
        }).disposed(by: self.disposeBag)
    }
}
