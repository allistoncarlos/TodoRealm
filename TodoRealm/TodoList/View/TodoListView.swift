//
//  TodoListView.swift
//  TodoRealm
//
//  Created by Alliston Aleixo on 21/10/23.
//

import SwiftUI
import RealmSwift

struct TodoListView: View {
    @Environment(\.realmConfiguration) var configuration
    
    @ObservedObject var viewModel: ViewModel
    
    var body: some View {
        NavigationStack {
            VStack {
                if let todos = viewModel.todos {
                    List(todos, id: \._id) { todo in
                        Text(todo.name)
                    }
                }
            }
            .padding(.top, 10)
            
            .toolbar {
                Button(action: {}) {
                    NavigationLink(value: String()) {
                        Image(systemName: "plus")
                    }
                }
            }
            .navigationTitle("To Do")
        }
        .onAppear() {
            viewModel.setup(configuration: self.configuration)
        }
        .task {
            Task {
                await viewModel.fetchData()
            }
        }
    }
}

#Preview {
    TodoListView(
        viewModel: TodoListView.ViewModel()
    )
}
