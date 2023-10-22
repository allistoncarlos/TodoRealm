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
    var body: some Scene {
        WindowGroup {
            LoginView(
                viewModel: LoginView.ViewModel(
                    app: App(id: Config.appId)
                )
            )
        }
    }
}
