//
//  ViewController.swift
//  hackathonApp
//
//  Created by Юрий on 21.10.2023.
//

import UIKit

class ViewController: UIViewController {
    
    private let notificationManager = NotificationManager()
    
    private let sendButton = UIButton(type: .infoLight)

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        requestNotification()
    }

    private func requestNotification() {
        notificationManager.requestAuthorization { [weak self] access in
            if !access {
                self?.showDeniedAlert()
            }
        }
    }
    
    private func showDeniedAlert() {
        let alertController = UIAlertController(title: "Notifications not allowed", message: "Allow access to send push notification", preferredStyle: .alert)
        let tryAction = UIAlertAction(title: "Request", style: .default) { [weak self] _ in
            self?.requestNotification()
        }
        alertController.addAction(tryAction)
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { _ in
            alertController.dismiss(animated: true)
        }))
        
        present(alertController, animated: true)
    }
    
    private func setup() {
        view.backgroundColor = .white
        
        view.addSubview(sendButton)
        sendButton.translatesAutoresizingMaskIntoConstraints = false
        sendButton.setTitleColor(.white, for: .normal)
        sendButton.setTitle("Send", for: .normal)
        sendButton.backgroundColor = .systemBlue
        sendButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        sendButton.widthAnchor.constraint(equalToConstant: 75).isActive = true
        sendButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        sendButton.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        sendButton.addTarget(self, action: #selector(sendNotification), for: .touchUpInside)
    }
    
    @objc
    func sendNotification() {
        notificationManager.sendNotification()
    }

}

extension ViewController: UNUserNotificationCenterDelegate {
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        
    }
}

