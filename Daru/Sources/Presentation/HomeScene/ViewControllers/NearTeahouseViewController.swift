//
//  NearTeahouseViewController.swift
//  Daru
//
//  Created by 재영신 on 2022/05/29.
//

import UIKit
import SnapKit
import Then
import ReactorKit
import MapKit

final class NearTeahouseViewController: BaseViewController, View {
    
    let locationManager = CLLocationManager()
    
    private let mainCollectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: UICollectionViewLayout()
    ).then {
        $0.showsVerticalScrollIndicator = false
        $0.register(
            NearTeahouseTitleCell.self,
            forCellWithReuseIdentifier: NearTeahouseTitleCell.identifier
        )
        $0.register(
            TeahouseListHeaderView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: TeahouseListHeaderView.identifier
        )
        $0.register(
            TeaHouseCell.self,
            forCellWithReuseIdentifier: TeaHouseCell.identifier
        )
        $0.register(LocationPermissionButtonCell.self,
                    forCellWithReuseIdentifier: LocationPermissionButtonCell.identifier
        )
    }
    
    init(reactor: NearTeahouseReactor) {
        super.init(nibName: nil, bundle: nil)
        self.reactor = reactor
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func configureUI() {
        super.configureUI()
        
        view.addSubview(mainCollectionView)
        
        mainCollectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        //mainCollectionView.collectionViewLayout = createLayout()
    }
    
    func bind(reactor: NearTeahouseReactor) {
        
        // MARK: - Action
        Observable.just(getCurrentLocationPermission())
            .map{ Reactor.Action.refresh(locationPermissionType: $0) }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        // MARK: - State
        reactor.pulse(\.$sections)
            .bind(to: mainCollectionView.rx.items(dataSource: NearTeahouseDataSource.dataSource(delegate: self)))
            .disposed(by: disposeBag)
        
        reactor.state.map(\.locationPermissionType)
            .distinctUntilChanged()
            .withUnretained(self)
            .bind {
                owner, type in
                switch type {
                case .allow:
                    owner.mainCollectionView.collectionViewLayout = owner.createLayout()
                case .notDetermined, .denied:
                    owner.mainCollectionView.collectionViewLayout = owner.createNotAllowLocationPermissionLayout()
                }
            }.disposed(by: disposeBag)
    }
}

private extension NearTeahouseViewController {
    func createLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { [weak self] section, environment -> NSCollectionLayoutSection? in
            switch section {
            case 0:
                return self?.createTitleSection()
            case 1:
                return self?.createNearTeaHouseSection()
            default:
                return nil
            }
        }
    }
    
    func createNotAllowLocationPermissionLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { [weak self] section, environment -> NSCollectionLayoutSection? in
            switch section {
            case 0:
                return self?.createTitleSection()
            case 1:
                return self?.createLocationPermissionButtonSection()
            default:
                return nil
            }
        }
    }
    
    func createTitleSection() -> NSCollectionLayoutSection {
        //item
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(70.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        //group
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(70.0))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 1)
        
        //section
        let section = NSCollectionLayoutSection(group: group)
        
        return section
    }
    
    func createNearTeaHouseSection() -> NSCollectionLayoutSection {
        //item
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        //group
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(0.298))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 2)
        group.interItemSpacing = .fixed(10.0)
        //section
        let section = NSCollectionLayoutSection(group: group)
        //section.orthogonalScrollingBehavior = .continuous
        section.boundarySupplementaryItems = [
            createNearTeaHouseSectionHeader()
        ]
        section.contentInsets = .init(top: 0.0, leading: 20.0, bottom: 0.0, trailing: 20.0)
        section.interGroupSpacing = 10.0
        return section
    }
    
    private func createNearTeaHouseSectionHeader() -> NSCollectionLayoutBoundarySupplementaryItem {
        
        //Section Header 사이즈
        let layoutSectionHeaderSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(46.0))
        
        //Section Header layout
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: layoutSectionHeaderSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .topLeading)
        //sectionHeader.contentInsets = .init(top: 0, leading: 20.0, bottom: 0, trailing: 0)
        return sectionHeader
    }
    
    private func createLocationPermissionButtonSection() -> NSCollectionLayoutSection {
        //item
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(200.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        //group
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(200.0))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 1)
        //section
        let section = NSCollectionLayoutSection(group: group)
        //section.orthogonalScrollingBehavior = .continuous
        section.boundarySupplementaryItems = [
            createNearTeaHouseSectionHeader()
        ]
        section.contentInsets = .init(top: 0.0, leading: 20.0, bottom: 0.0, trailing: 20.0)
        //section.interGroupSpacing = 10.0
        return section
    }
}

private extension NearTeahouseViewController {
    func getCurrentLocationPermission() -> LocationPermissionType {
        if #available(iOS 14.0, *) {
            switch locationManager.authorizationStatus {
            case .authorizedAlways, .authorizedWhenInUse:
                return .allow
            case .denied, .restricted:
                return .denied
            case .notDetermined:
                return .notDetermined
            @unknown default:
                return .notDetermined
            }
        } else {
            switch CLLocationManager.authorizationStatus() {
            case .authorizedAlways, .authorizedWhenInUse:
                return .allow
            case .denied, .restricted:
                return .denied
            case .notDetermined:
                return .notDetermined
            @unknown default:
                return .notDetermined
            }
        }
    }
    
    func requestAllowLocationPermission() {
        if #available(iOS 14.0, *) {
            switch locationManager.authorizationStatus {
            case .notDetermined, .restricted:
                locationManager.requestWhenInUseAuthorization()
            case .denied:
                sendSettingAlertAction()
                break
            case .authorizedAlways, .authorizedWhenInUse:
                break
            @unknown default:
                return
            }
        } else {
            switch CLLocationManager.authorizationStatus() {
            case .notDetermined, .restricted:
                locationManager.requestWhenInUseAuthorization()
            case .denied:
                sendSettingAlertAction()
                break
            case .authorizedAlways, .authorizedWhenInUse:
                break
            @unknown default:
                return
            }
        }
    }
    
    func sendSettingAlertAction() {
        reactor?.action.onNext(.settingAlertIsRequired)
    }
}

extension NearTeahouseViewController: LocationPermissionButtonDelegate {
    func locationPermissionButtonDidTap() {
        requestAllowLocationPermission()
    }
}
