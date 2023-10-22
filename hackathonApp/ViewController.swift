//
//  ViewController.swift
//  hackathonApp
//
//  Created by Юрий on 21.10.2023.
//

import UIKit
import OneGoLayoutConstraint

class ViewController: UIViewController {
    
    enum Section {
        case progress
        case fields
    }
    
    enum Item {
        case progress
        case fields
    }
    
    enum Constants {
        static let headerTitles = ["Регистрация", "Регистрация пользователя"]
        static let headerFonts = [
            UIFont.systemFont(ofSize: 26, weight: .bold),
            UIFont.systemFont(ofSize: 16, weight: .bold)
        ]
        static let headerColors = [
            UIColor.black,
            #colorLiteral(red: 0.1494038105, green: 0.2952361107, blue: 0.5088882446, alpha: 1)
        ]
    }
    
    private let notificationManager = NotificationManager()
    private let networkService = NetworkService()
    
    private let sendButton = UIButton(type: .infoLight)
    private lazy var collectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: createLayout()
    )
    
    private lazy var dataSource = configureDataSource()

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        requestNotification()
        
        var snapshot = dataSource.snapshot()
        snapshot.appendSections([.progress, .fields])
        snapshot.appendItems([.progress], toSection: .progress)
        snapshot.appendItems([.fields], toSection: .fields)
        dataSource.apply(snapshot)
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
        
        view.addSubview(collectionView)
        collectionView.pinToSuperView(sides: .topR, .leftR, .rightR)
        collectionView.register(ProgressCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.register(RegisterCell.self, forCellWithReuseIdentifier: "cellReg")
        collectionView.register(
            ProgressHeader.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: "header"
        )
        
        view.addSubview(sendButton)
        sendButton.pin(side: .top(16), to: .bottom(collectionView))
        sendButton.pinToSuperView(sides: .left(20), .right(-20), .bottom(-32))
        sendButton.setDemission(.height(48))
        sendButton.setTitle("Отправить", for: .normal)
        sendButton.setTitleColor(.white, for: .normal)
        sendButton.titleLabel?.textAlignment = .center
        sendButton.backgroundColor = .systemBlue
        sendButton.layer.cornerRadius = 12
        sendButton.addTarget(self, action: #selector(sendNotification), for: .touchUpInside)
    }
    
    func configureDataSource() -> UICollectionViewDiffableDataSource<Section, Item> {
        let dataSource = UICollectionViewDiffableDataSource<Section,Item>(collectionView: collectionView) { collectionView, indexPath, model in
            switch model {
            case .progress:
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? ProgressCell
                else { return UICollectionViewCell() }
                cell.configure(lastFilled: 0)
                return cell
            case .fields:
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellReg", for: indexPath) as? RegisterCell
                else { return UICollectionViewCell() }
                cell.configure(fieldTypes: [.name, .secondName, .password])
                return cell
            }
        }
        
        dataSource.supplementaryViewProvider = { collectionView, elementKind, indexPath in
            guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: elementKind, withReuseIdentifier: "header", for: indexPath) as? ProgressHeader
            else { return UICollectionReusableView() }
            header.configure(
                text: Constants.headerTitles[indexPath.section],
                font: Constants.headerFonts[indexPath.section],
                color: Constants.headerColors[indexPath.section]
            )
            return header
        }
        
        return dataSource
    }
    
    private func createLayout() -> UICollectionViewLayout {
        return UICollectionViewCompositionalLayout { _, _ in
            let itemSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .estimated(1.0)
            )
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            let groupSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .estimated(1.0)
            )
            let group = NSCollectionLayoutGroup.horizontal(
                layoutSize: groupSize,
                subitems: [item]
            )
            let section = NSCollectionLayoutSection(group: group)
            let headerSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .estimated(1.0)
            )
            let header = NSCollectionLayoutBoundarySupplementaryItem(
                layoutSize: headerSize,
                elementKind: UICollectionView.elementKindSectionHeader,
                alignment: .top
            )
            section.boundarySupplementaryItems = [header]
            return section
        }
    }
    
    func showToast(type: ToastType) {
        let toast = ToastView(frame: CGRect(x: 20, y: -90, width: view.bounds.width-40, height: 90))
        toast.configure(type: type)
        view.addSubview(toast)
        UIView.animate(withDuration: 0.5) {
            toast.transform = .init(translationX: 0, y: 160)
        }
        DispatchQueue.main.asyncAfter(deadline: .now()+5) {
            UIView.animate(withDuration: 0.5) {
                toast.transform = .identity
            }
        }
    }
    
    func createRandomError() -> ErrorEntry {
        let errors = [
            ErrorEntry(
                error_type: "Textfield",
                details: "Password validation error",
                priority: "Low"
            ),
            ErrorEntry(
                error_type: "View",
                details: "Some problems with platform",
                priority: "Low"
            ),
            ErrorEntry(
                error_type: "Network",
                details: "Couldn't get data",
                priority: "High"
            ),
            ErrorEntry(
                error_type: "Database",
                details: "Password validation error",
                priority: "Medium"
            ),
            ErrorEntry(
                error_type: "Database",
                details: "Minor latency issues 21212",
                priority: "High"
            ),
        ]
        return errors[Int.random(in: 0..<errors.count)]
    }
    
    @objc
    func sendNotification() {
        let model = createRandomError()
        networkService.reportError(error: model) { error in
            DispatchQueue.main.async {
                if let error {
                    print(error)
                } else {
                    self.showToast(type: .notification(.error("Напишите в техническую поддержку для помощи")))
                    self.notificationManager.sendNotification()
                }
            }
        }
    }

}

extension ViewController: UNUserNotificationCenterDelegate {
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        
    }
}

