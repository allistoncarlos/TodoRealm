//
//  TodoRealmApp.swift
//  TodoRealm
//
//  Created by Alliston Aleixo on 21/10/23.
//

import SwiftUI
import RealmSwift

@main
struct TodoRealmApp: SwiftUI.App {
    private var app = App(id: Config.appId)
    
    var body: some Scene {
        WindowGroup {
            resultView()
        }
    }
    
    @MainActor
    private func resultView() -> some View {
        return if let user = app.currentUser {
            AnyView(todoListView(user: user))
        } else {
            AnyView(loginView())
        }
    }
    
    @MainActor
    private func loginView() -> some View {
        LoginView(viewModel: LoginView.ViewModel())
            .environmentObject(app)
    }
    
    @MainActor
    private func todoListView(user: User) -> some View {
        TodoListView(
            viewModel: TodoListView.ViewModel()
        )
        .environment(\.realmConfiguration, user.flexibleSyncConfiguration(
            clientResetMode: .recoverUnsyncedChanges(),
            initialSubscriptions: { subs in
                subs.append(QuerySubscription<Todo>())
            }
        ))
    }
}
