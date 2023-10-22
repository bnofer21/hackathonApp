//
//  ToastType.swift
//  hackathonApp
//
//  Created by Юрий on 22.10.2023.
//

import Foundation
import UIKit

enum ToastType {
    case notification(ToastInfoType)
    case info(ToastInfoType)
    
    var infoType: ToastInfoType {
        switch self {
        case .notification(let type), .info(let type):
            return type
        }
    }
    
    var isIconHidden: Bool {
        switch self {
        case .notification:
            return true
        case .info:
            return false
        }
    }
}

enum ToastInfoType {
    case success(String? = nil)
    case info(String? = nil)
    case warning(String? = nil)
    case error(String? = nil)
    
    var mainText: String {
        switch self {
        case .success:
            return "Успешно!"
        case .info:
            return "Информация!"
        case .warning:
            return "Предупреждение"
        case .error:
            return "Ошибка"
        }
    }
    
    var subText: String {
        switch self {
        case .success(let text):
            return text ?? "Оповещение об успешно выполненом сценарии на странице"
        case .info(let text):
            return text ?? "Информация о важных событиях в интерфейсе"
        case .warning(let text):
            return text ?? "Информация об особенностях на странице"
        case .error(let text):
            return text ?? "Информация о критической ошибке на странице"
        }
    }
    
    
    var backgroundColor: UIColor {
        switch self {
        case .success:
            return #colorLiteral(red: 0.9405844808, green: 0.9832455516, blue: 0.9692428708, alpha: 1)
        case .info:
            return #colorLiteral(red: 0.9479405284, green: 0.9808869958, blue: 0.9993668199, alpha: 1)
        case .warning:
            return #colorLiteral(red: 0.9850293994, green: 0.9718123078, blue: 0.9445706606, alpha: 1)
        case .error:
            return #colorLiteral(red: 0.9907810092, green: 0.941798389, blue: 0.9497401118, alpha: 1)
        }
    }
    
    var progressColor: UIColor {
        switch self {
        case .success:
            return #colorLiteral(red: 0.05643195659, green: 0.6089050174, blue: 0.4080650806, alpha: 1)
        case .info:
            return #colorLiteral(red: 0.1523160636, green: 0.564240694, blue: 0.8622363806, alpha: 1)
        case .warning:
            return #colorLiteral(red: 0.882656157, green: 0.6142911911, blue: 0.1068649665, alpha: 1)
        case .error:
            return #colorLiteral(red: 0.8828106523, green: 0.1402371228, blue: 0.1890031993, alpha: 1)
        }
    }
    
    var borderColor: UIColor {
        switch self {
        case .success:
            return #colorLiteral(red: 0.6683940291, green: 0.8713554144, blue: 0.800067246, alpha: 1)
        case .info:
            return #colorLiteral(red: 0.7694855332, green: 0.8498594165, blue: 0.9130043983, alpha: 1)
        case .warning:
            return #colorLiteral(red: 0.9016712904, green: 0.8435804248, blue: 0.7243883014, alpha: 1)
        case .error:
            return #colorLiteral(red: 0.928943634, green: 0.8078072667, blue: 0.8238657713, alpha: 1)
        }
    }
    
    var icon: UIImage {
        switch self {
        case .success:
            return #imageLiteral(resourceName: "success")
        case .info:
            return #imageLiteral(resourceName: "info")
        case .warning:
            return #imageLiteral(resourceName: "warning")
        case .error:
            return #imageLiteral(resourceName: "error")
        }
    }
}
