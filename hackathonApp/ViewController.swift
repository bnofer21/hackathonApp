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
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        showToast()
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
        collectionView.pinToSuperView()
        collectionView.register(ProgressCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.register(RegisterCell.self, forCellWithReuseIdentifier: "cellReg")
        collectionView.register(
            ProgressHeader.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: "header"
        )
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
    
    func showToast() {
        let types: [ToastType] = [.notification(.error), .notification(.warning), .notification(.info), .notification(.success)]
        let randomType = types[Int.random(in: 0...3)]
        
        let toast = ToastView(frame: CGRect(x: 20, y: -90, width: view.bounds.width-40, height: 90))
        toast.configure(type: randomType)
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
    
    @objc
    func sendNotification() {
        notificationManager.sendNotification()
    }

}

extension ViewController: UNUserNotificationCenterDelegate {
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        
    }
}

