//
//  MainViewModel.swift
//  Gallery
//
//  Created by Victor Sukochev on 14.08.2021.
//

import Combine
import RxSwift

class MainViewModel: MainViewModelProtocol {
    
    @Published var photos: [FeedPhotoEntity] = []
    @Published var error: Error? = nil
    @Published var isErrorOccured: Bool = false
    
    private let feedManager: FeedManagerProtocol
    private let networkManager: NetworkManagerProtocol
    
    private let disposeBag = DisposeBag()
    
    init() {
        let container = InjectionContainer.container
        
        self.feedManager = container.resolve(FeedManagerProtocol.self)!
        self.networkManager = container.resolve(NetworkManagerProtocol.self)!
        
        self.setupBindings()
        
        self.feedManager.fetchNext()
    }
    
    // MARK: -
    
    private func setupBindings() {
        self.feedManager.photos.observe(on: MainScheduler.instance).subscribe(onNext: { [weak self] photos in
            
        }).disposed(by: self.disposeBag)
        
        self.networkManager.error.observe(on: MainScheduler.instance).subscribe(onNext: { [weak self] error in
            self?.error = error
            self?.isErrorOccured = true
        }).disposed(by: self.disposeBag)
    }
}
