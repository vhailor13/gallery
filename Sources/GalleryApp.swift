//
//  GalleryApp.swift
//  Gallery
//
//  Created by Victor Sukochev on 14.08.2021.
//

import SwiftUI
import Swinject

class InjectionContainer {
    static let container = Container()
}

@main
struct GalleryApp: App {
    @State var isAuthorized: Bool = false
    
    init() {
        self.setupInjections()
    }
    
    var body: some Scene {
        WindowGroup {
            RootView(RootViewModel())
        }
    }
    
    // MARK: -
    
    private func setupInjections() {
        let container = InjectionContainer.container
        
        container.register(ApiServiceProtocol.self) { _ in
            ApiService.shared
        }
        
        container.register(AuthManagerProtocol.self) { _ in
            AuthManager.shared
        }
    }
}
