//
//  ApiService.swift
//  Gallery
//
//  Created by Victor Sukochev on 14.08.2021.
//

import GraphQL_Swift
import RxSwift
import RxRelay

class ApiService: ApiServiceProtocol {
    static let shared = ApiService()
    
    var isAuthorized: Observable<Bool> {
        return self.isAuthorizedRelay.asObservable()
    }
    
    private var auth = DefaultAuth()
    private var networkCtrl = GQLNetworkController(apiDefinition: DefaultApiDefinition())
    
    private var isAuthorizedRelay = BehaviorRelay<Bool>(value: false)
    
    private init() {}
    
    
    func login(email: String, password: String) -> Completable  {
        return Completable.create { completable in
            let query = DefaultQuery("""
                mutation {
                  accountLogin(input: { email: \"\(email)\", password: \"\(password)\" }) {
                    success
                    auth_token
                  }
                }
                """)
            
            do {
                let dataTask = try self.networkCtrl.makeGraphQLRequest(query) { [unowned self] results in
                    switch results {
                    case .success(let jsonResults):
                        do {
                            let dataResults = try jsonResults.parseDataKey()
                            
                            // Storing token if available
                            if let account = dataResults["accountLogin"] as? [String: Any] {
                                if let token = account["auth_token"] as? String {
                                    self.auth.jwt = token
                                    
                                    self.networkCtrl = GQLNetworkController(apiDefinition: DefaultApiDefinition(authorization: self.auth))
                                    
                                    self.isAuthorizedRelay.accept(true)
                                }
                            }
                            
                            
                            completable(.completed)
                        } catch {
                            completable(.error(error))
                        }
                        break
                        
                    case .fail(let error):
                        completable(.error(error))
                        break
                    }
                }
                
                dataTask.resume()
            } catch {
                completable(.error(error))
            }
            
            return Disposables.create()
        }
    }
    
    func fetch(_ query: String) -> Single<[String: Any]> {
       return Single<[String: Any]>.create { single in
            let query = DefaultQuery(query)
            
            do {
                let dataTask = try self.networkCtrl.makeGraphQLRequest(query) { results in
                    switch results {
                    case .success(let jsonResults):
                        do {
                            let dataResults = try jsonResults.parseDataKey()
                            
                            single(.success(dataResults))
                        } catch {
                            single(.failure(error))
                        }
                        break
                        
                    case .fail(let error):
                        single(.failure(error))
                        break
                    }
                }
                
                dataTask.resume()
            } catch {
                single(.failure(error))
            }
            
            return Disposables.create()
        }
    }
}
