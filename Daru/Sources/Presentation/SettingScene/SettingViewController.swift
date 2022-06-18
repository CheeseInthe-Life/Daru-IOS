//
//  SettingViewController.swift
//  Daru
//
//  Created by 재영신 on 2022/06/18.
//

import UIKit
import SnapKit
import Then
import ReactorKit

final class SettingViewController: BaseViewController, View {
    
    private let settingTableView = UITableView(
        frame: .zero,
        style: .grouped
    ).then {
        $0.register(SettingItemCell.self, forCellReuseIdentifier: SettingItemCell.identifier)
        //$0.separatorStyle = .none
        $0.separatorColor = .brown3
        $0.backgroundColor = .systemBackground
    }
    
    init(reactor: SettingReactor) {
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
        
        view.addSubview(settingTableView)
        
        settingTableView.snp.makeConstraints { make in
            make.top.bottom.trailing.equalToSuperview()
            make.leading.equalToSuperview().inset(40.0)
        }
    }
    
    func bind(reactor: SettingReactor) {
        
        settingTableView.rx.setDelegate(self).disposed(by: disposeBag)
        
        Observable.just(
            [
                SettingItemType.teahouseOwner,
                SettingItemType.terms,
                SettingItemType.daruInfo,
                SettingItemType.personal
            ]
        ).bind(to: settingTableView.rx.items(cellIdentifier: SettingItemCell.identifier, cellType: SettingItemCell.self)) {
            index, type, cell in
            cell.update(with: type)
        }.disposed(by: disposeBag)
    }
}

extension SettingViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = SettingHeaderView()
        return view
    }
}
