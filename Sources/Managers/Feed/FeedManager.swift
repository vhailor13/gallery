//
//  FeedManager.swift
//  Gallery
//
//  Created by Victor Sukochev on 15.08.2021.
//

import RxSwift
import RxRelay

class FeedManager: FeedManagerProtocol {
    static let shared = FeedManager()
    
    var photos: Observable<[FeedPhotoEntity]> {
        return self.photosRelay.asObservable()
    }
    
    private let networkManager: NetworkManagerProtocol
    
    private var photosRelay = BehaviorRelay<[FeedPhotoEntity]>(value: [])
    private var photosMap: [String: FeedPhotoEntity] = [:]
    
    private let disposeBag = DisposeBag()
    
    private init() {
        let container = InjectionContainer.container
        
        self.networkManager = container.resolve(NetworkManagerProtocol.self)!
    }
    
    func fetchNext() {
        self.networkManager.fetch("""
            query {
              album(id: "exHbvthJfbuFwiusSJuVAm") {
                id
                name
                photos(slice: { limit: \(Config.fetchLimit), offset: \(self.photosRelay.value.count) }, for_web_gallery: true) {
                  records {
                    id
                    thumbnail_urls {
                      size_code
                      height
                      width
                      url
                    }
                  }
                }
              }
            }
            """).subscribe(onSuccess: { [unowned self] result in
                guard let albumDict = result["album"] as? [String: Any] else { return }
                guard let photosDict = albumDict["photos"] as? [String: Any] else { return }
                guard let recordsArray = photosDict["records"] as? [[String: Any]] else { return }
                
                let records = recordsArray.compactMap({ FeedPhotoEntity.parse($0) })
                var currentRecords = self.photosRelay.value
                currentRecords.append(contentsOf: records)
                
                self.photosRelay.accept(currentRecords)
                self.updatePhotosMap(records)
            }).disposed(by: self.disposeBag)
    }
    
    func photo(_ id: String) -> FeedPhotoEntity? {
        return self.photosMap[id]
    }
    
    // MARK: -
    
    private func updatePhotosMap(_ photos: [FeedPhotoEntity]) {
        photos.forEach({ self.photosMap[$0.id] = $0 })
    }
}
