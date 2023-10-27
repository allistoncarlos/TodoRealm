//
//  LoginViewModel.swift
//  TodoRealm
//
//  Created by Alliston Aleixo on 21/10/23.
//

import Foundation
import RealmSwift

extension LoginView {
    @MainActor
    class ViewModel: ObservableObject {
        @Published var model: LoginModel
        @Published var state: LoginState = .idle
        
        var app: App?
        
        init(model: LoginModel = LoginModel()) {
            self.model = model
        }
        
        func setup(app: App) {
            self.app = app
        }

        func login() async {
            if let app {
                do {
                    let user = try await app.login(credentials: Credentials.emailPassword(
                        email: model.username,
                        password: model.password)
                    )
                    
                    state = .success(user)
                } catch {
                    state = .error
                }
            }
        }
    }
}
