//
//  LoginState.swift
//  TodoRealm
//
//  Created by Alliston Aleixo on 22/10/23.
//

import Foundation
import RealmSwift

enum LoginState: Equatable {
    case idle
    case loading
    case success(User)
    case error
}
