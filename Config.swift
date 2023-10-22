//
//  Config.swift
//  TodoRealm
//
//  Created by Alliston Aleixo on 22/10/23.
//

import Foundation

internal enum Config {
    static let appId: String = (Bundle.main.infoDictionary!["APP_ID"] as? String)!
}
