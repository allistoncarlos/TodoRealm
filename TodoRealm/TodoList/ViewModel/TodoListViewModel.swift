//
//  TodoListViewModel.swift
//  TodoRealm
//
//  Created by Alliston Aleixo on 21/10/23.
//

import Foundation
import RealmSwift
import Combine

extension TodoListView {
    @MainActor
    class ViewModel: ObservableObject {
        private var cancellable = Set<AnyCancellable>()

        @Published var todos: [Todo]? = nil
        @Published var state: TodoListState = .idle
        
        var configuration: Realm.Configuration?
        
        init() {
            $state
                .receive(on: RunLoop.main)
                .sink { [weak self] state in
                    switch state {
                    case let .success(todos):
                        self?.todos = todos
                    default:
                        break
                    }
                }.store(in: &cancellable)
        }
        
        func setup(configuration: Realm.Configuration) {
            self.configuration = configuration
        }
        
        func fetchData() async {
            if let configuration {
                state = .loading
                
                do {
                    let realm = try await Realm(configuration: configuration, downloadBeforeOpen: .always)

                    let results = realm.objects(Todo.self)
                    
                    state = .success(Array(results))
                } catch {
                    state = .error("DEU RUIM")
                }
            }
        }
    }
}
