//
//  AuthState.swift
//  AezakmiApp
//
//  Created by Rahmonali on 21/09/24.
//

import Foundation

enum AuthState {
    case unauththicated
    case authenticated(uid: String)
}
