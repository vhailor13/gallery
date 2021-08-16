//
//  AuthView.swift
//  Gallery
//
//  Created by Victor Sukochev on 14.08.2021.
//

import SwiftUI

struct AuthView<T: AuthViewModelProtocol>: View {
    init(_ viewModel: T) {
        self.viewModel = viewModel
    }
    
    @ObservedObject var viewModel: T
    
    var body: some View {
        ZStack {
            VStack {
                VStack(alignment: .leading) {
                    TextField("Email", text: $viewModel.email)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        
                    SecureField("Password", text: $viewModel.password)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        
                }.padding(EdgeInsets(top: 0.0, leading: 12.0, bottom: 0.0, trailing: 12.0))
                
                Button {
                    viewModel.signIn()
                } label: {
                    Text("Sign In")
                        .foregroundColor(.blue)
                }
            }
            
            if viewModel.isInProgress {
                authProgressView()
                    .edgesIgnoringSafeArea(.all)
            }
        }.alert(isPresented: $viewModel.isErrorOccured) {
            Alert(
                title: Text("Error"),
                message: Text(viewModel.error?.localizedDescription ?? ""),
                dismissButton: .default(Text("OK")))
        }
    }
    
     // MARK: -
    
    private func authProgressView() -> some View {
        ZStack {
            Color.black.opacity(0.85)
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle(tint: .white))
        }
    }
}

// In general every component can be tested via stubbing related protocols
// E.g. previews can be generated via stubbing ViewModel

class AuthViewModelStub: AuthViewModelProtocol {
    @Published var email: String = "test@email.com"
    @Published var password: String = "testpassword"
    
    @Published var error: Error? = nil
    var isErrorOccured: Bool = false
    @Published var isInProgress: Bool = false
    
    func signIn() {}
}

struct AuthView_Previews: PreviewProvider {
    static var previews: some View {
        AuthView(AuthViewModelStub())
    }
}
