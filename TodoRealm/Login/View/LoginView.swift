//
//  LoginView.swift
//  TodoRealm
//
//  Created by Alliston Aleixo on 21/10/23.
//

import SwiftUI
import RealmSwift
import Realm

struct LoginView: View {
    @EnvironmentObject var app: RLMApp
    
    @ObservedObject var viewModel: ViewModel
    
    var body: some View {
        ZStack {
            if case let LoginState.success(user) = viewModel.state {
                TodoListView(
                    viewModel: TodoListView.ViewModel()
                )
                .environment(\.realmConfiguration, user.flexibleSyncConfiguration(
                    clientResetMode: .recoverUnsyncedChanges(),
                    initialSubscriptions: { subs in
                        subs.append(QuerySubscription<Todo>())
                    }
                ))
            } else {
                NavigationStack {
                    Form {
                        Section {
                            TextField("Username", text: $viewModel.model.username)
                                .keyboardType(.emailAddress)
                                .autocapitalization(.none)
                            
                            SecureField("Password", text: $viewModel.model.password)
                        } footer: {
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
                        }

                    }
                    .navigationTitle("Login")
                    .onChange(of: viewModel.state) { oldValue, newValue in
                        print("CHANGE: \(oldValue) - \(newValue)")
                    }
                }
                
                if viewModel.state == .error {
                    alertView()
                }
            }
        }
        .onAppear {
            viewModel.setup(app: app)
        }
    }
    
    func alertView() -> AnyView {
        let errorMessage = "Usuário ou senha inválidos"

        return AnyView(Text("")
            .alert(isPresented: .constant(true)) {
                Alert(
                    title: Text("TodoRealm"),
                    message: Text(errorMessage),
                    dismissButton: .default(Text("OK"), action: { })
                )
            }
        )
    }
}

#Preview {
    LoginView(
        viewModel: LoginView.ViewModel()
    )
}
