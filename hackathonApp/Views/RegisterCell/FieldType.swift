//
//  FieldType.swift
//  hackathonApp
//
//  Created by Юрий on 22.10.2023.
//

import Foundation

enum FieldType {
    case name
    case secondName
    case password
    
    var placeholder: String {
        switch self {
        case .name:
            return "Имя*"
        case .secondName:
            return "Фамилия*"
        case .password:
            return "Пароль*"
        }
    }
    
    var needHelp: Bool {
        switch self {
        case .password:
            return true
        default:
            return false
        }
    }
}
