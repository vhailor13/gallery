//
//  RootViewModel.swift
//  Gallery
//
//  Created by Victor Sukochev on 14.08.2021.
//

import Combine
import RxSwift

class RootViewModel: RootViewModelProtocol {
    @Published private(set) var isAuthorized: Bool = false
    
    private let authManager: AuthManagerProtocol
    
    private let disposeBag = DisposeBag()
    
    init() {
        let container = InjectionContainer.container
        self.authManager = container.resolve(AuthManagerProtocol.self)!
        
        self.setupBindings()
    }
    
    // MARK: -
    
    private func setupBindings() {
        self.authManager.isAuthorized.observe(on: MainScheduler.instance).subscribe(onNext: { [weak self] state in
            self?.isAuthorized = state
        }).disposed(by: self.disposeBag)
    }
}
