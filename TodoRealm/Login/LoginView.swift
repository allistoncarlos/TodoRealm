//
//  LoginView.swift
//  TodoRealm
//
//  Created by Alliston Aleixo on 21/10/23.
//

import SwiftUI
import RealmSwift

struct LoginView: View {
    @State var viewModel: ViewModel
    
    var body: some View {
        NavigationStack {
            Form {
                TextField("Username", text: $viewModel.model.username)
                    .keyboardType(.emailAddress)
                
                SecureField("Password", text: $viewModel.model.password)

                Section(
                    footer:
                    Button("Login") {
                        Task {
                            await viewModel.login()
                        }
                    }
                    .padding()
                    .frame(
                        minWidth: 0,
                        maxWidth: .infinity
                    )
                    .background(.blue)
                    .foregroundColor(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 5))
                    .font(.system(size: 18, weight: .bold))
                ) {
                    EmptyView()
                }
            }
            .navigationTitle("Login")
        }
    }
}

#Preview {
    LoginView(
        viewModel: LoginView.ViewModel(
            app: App(id: Config.appId)
        )
    )
}
