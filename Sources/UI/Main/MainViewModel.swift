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
    
    private let networkManager: NetworkManagerProtocol
    
    private let disposeBag = DisposeBag()
    
    init() {
        let container = InjectionContainer.container
        self.networkManager = container.resolve(NetworkManagerProtocol.self)!
        
        self.setupBindings()
    }
    
    // MARK: -
    
    private func setupBindings() {
        self.networkManager.error.observe(on: MainScheduler.instance).subscribe(onNext: { [weak self] error in
            self?.error = error
            self?.isErrorOccured = true
        }).disposed(by: self.disposeBag)
    }
}
