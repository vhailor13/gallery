//
//  FeedViewModel.swift
//  Gallery
//
//  Created by Victor Sukochev on 16.08.2021.
//

import Combine
import RxSwift

class FeedViewModel: FeedViewModelProtocol {
    @Published var photos: [FeedPhotoEntity] = []
    
    private let feedManager: FeedManagerProtocol
    
    private let diseposeBag = DisposeBag()
    
    init() {
        let container = InjectionContainer.container
        
        self.feedManager = container.resolve(FeedManagerProtocol.self)!
        
        self.setupBindings()
    }
    
    // MARK: -
    
    private func setupBindings() {
        self.feedManager.photos.observe(on: MainScheduler.instance).subscribe(onNext: { [weak self] photos in
            self?.photos = photos
        }).disposed(by: self.diseposeBag)
    }
}
