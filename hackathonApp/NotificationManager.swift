//
//  NotificationManager.swift
//  hackathonApp
//
//  Created by Юрий on 21.10.2023.
//

import Foundation
import UserNotifications

final class NotificationManager {
    
    private let notificationService = UNUserNotificationCenter.current()
    
    func requestAuthorization(completion: @escaping  (Bool) -> Void) {
        notificationService.requestAuthorization(options: [.alert, .sound, .badge]) { granted, _  in
            completion(granted)
        }
    }
    
    func sendNotification() {
        let content = UNMutableNotificationContent()
        content.title = "ЕЦП снова работает"
        content.body = "Вы снова можете подписывать свои документы"
        content.badge = 1
        
        let triger = UNTimeIntervalNotificationTrigger(timeInterval: 2, repeats: false)
        
        let request = UNNotificationRequest(identifier: "test", content: content, trigger: triger)
        
        notificationService.add(request)
    }
    
}
