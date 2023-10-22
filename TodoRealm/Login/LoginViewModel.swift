//
//  LoginViewModel.swift
//  TodoRealm
//
//  Created by Alliston Aleixo on 21/10/23.
//

import Foundation
import RealmSwift

extension LoginView {
    class ViewModel {
        @Published var model: LoginModel
        
        var app: RealmSwift.App
        
        init(app: RealmSwift.App, model: LoginModel = LoginModel()) {
            self.app = app
            self.model = model
        }
        
        func login() async {
            app.login(credentials: Credentials.emailPassword(
                email: model.username,
                password: model.password)
            ) { (result) in
                switch result {
                case .failure(let error):
                    print("Login failed: \(error.localizedDescription)")
                case .success(let user):
                    print("Successfully logged in as user \(user)")
                }
            }
        }
    }
}
