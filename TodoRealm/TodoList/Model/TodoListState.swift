//
//  TodoListState.swift
//  TodoRealm
//
//  Created by Alliston Aleixo on 22/10/23.
//

import Foundation

enum TodoListState: Equatable {
    case idle
    case loading
    case success([Todo])
    case error(String)
}
