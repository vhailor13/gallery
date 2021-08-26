//
//  ApiService.swift
//  Gallery
//
//  Created by Victor Sukochev on 14.08.2021.
//

import RxSwift
import RxRelay
import Apollo

class ApiService: ApiServiceProtocol {
    static let shared = ApiService()
    
    var isAuthorized: Observable<Bool> {
        return self.isAuthorizedRelay.asObservable()
    }
    
    private let apollo = ApolloClient(url: URL(string: Config.apiUrlStr)!)
    
    private var isAuthorizedRelay = BehaviorRelay<Bool>(value: false)
    
    private init() {}
    
    
    func login(email: String, password: String) -> Completable {
        return Completable.create { completable in
            self.apollo.perform(mutation: LoginMutation(email: email, password: password)) { result in
                switch result {
                case .success(let result):
                    if let error = result.errors?.first {
                        self.isAuthorizedRelay.accept(false)
                        completable(.error(error))
                        break
                    }
                    
                    self.isAuthorizedRelay.accept(true)
                    completable(.completed)
                    break
                    
                case .failure(let error):
                    self.isAuthorizedRelay.accept(false)
                    completable(.error(error))
                    break
                }
            }
            
            return Disposables.create()
        }
    }
    
    func fetch<Query: GraphQLQuery>(_ query: Query) -> Single<Query.Data?> {
       return Single<Query.Data?>.create { single in
        
            self.apollo.fetch(query: query) { result in
                switch result {
                case .success(let result):
                    if let error = result.errors?.first {
                        single(.failure(error))
                        break
                    }
                    
                    single(.success(result.data))
                    break
                    
                case .failure(let error):
                    single(.failure(error))
                    break
                    
                }
            }
        
            return Disposables.create()
        }
    }
}
