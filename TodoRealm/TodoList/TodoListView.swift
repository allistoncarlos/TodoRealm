//
//  TodoListView.swift
//  TodoRealm
//
//  Created by Alliston Aleixo on 21/10/23.
//

import SwiftUI

struct TodoListView: View {
    @State private var viewModel: ViewModel
    
    var body: some View {
        Text("Hello, World!")
    }
    
    init() {
        _viewModel = State(initialValue: ViewModel())
    }
}

#Preview {
    return TodoListView()
}
