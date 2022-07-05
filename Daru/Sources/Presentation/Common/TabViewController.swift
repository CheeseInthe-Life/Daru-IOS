//
//  TabViewController.swift
//  Daru
//
//  Created by 재영신 on 2022/05/16.
//

import UIKit
import Tabman
import Pageboy
import Then
import SnapKit
import RxFlow
import RxCocoa

final class TabViewController: TabmanViewController, Stepper {
    
    var steps: PublishRelay<Step> = .init()
    
    private var tabs = [(name: String, viewController: UIViewController)]()
    
    private let leftTitleLabel = UILabel().then {
        $0.text = "다루"
        $0.font = .notoSansKR(.bold, size: 18.0)
    }
    
    private let searchTextField = UITextField().then {
        let searchButton = UIButton()
        searchButton.setImage(Constant.searchIcon, for: .normal)
        searchButton.contentEdgeInsets = .init(top: 0, left: 0, bottom: 0, right: 18.0)
        $0.rightView = searchButton
        $0.rightViewMode = .always
        $0.backgroundColor = .gray7
        $0.layer.cornerRadius = 20.0
    }
    
    func setTabs(tabs: [(name: String, viewController: UIViewController)]) {
        self.tabs = tabs
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.dataSource = self
        searchTextField.snp.makeConstraints { make in
            make.height.equalTo(40.0)
            make.width.equalTo(UIScreen.main.bounds.width - 157.0)
        }
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: leftTitleLabel)
        navigationItem.titleView = searchTextField
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: Constant.settingIcon,
            style: .plain,
            target: self,
            action: #selector(settingButtonDidTap)
        )
        //navigationController?.navigationBar.isTranslucent = false
        
        
        // Create bar
        let bar = TMBar.ButtonBar()
        bar.layout.transitionStyle = .snap // Customize
        bar.layout.contentMode = .fit
        bar.backgroundView.style = .flat(color: .systemBackground)
        bar.indicator.tintColor = .yellowGreen1
        bar.buttons.customize { button in
            button.selectedFont = .notoSansKR(.bold, size: 16.0)
            button.selectedTintColor = .black
            button.font = .notoSansKR(.regular, size: 16.0)
        }
        
        // Add to view
        addBar(bar, dataSource: self, at: .top)
    }

}

extension TabViewController: PageboyViewControllerDataSource, TMBarDataSource {
    func numberOfViewControllers(in pageboyViewController: PageboyViewController) -> Int {
        return tabs.count
    }
    
    func viewController(for pageboyViewController: PageboyViewController,
                        at index: PageboyViewController.PageIndex) -> UIViewController? {
        return tabs[index].viewController
    }
    
    func defaultPage(for pageboyViewController: PageboyViewController) -> PageboyViewController.Page? {
        return .at(index: 0)
    }
    
    func barItem(for bar: TMBar, at index: Int) -> TMBarItemable {
        return TMBarItem(title: tabs[index].name)
    }
}


extension TabViewController {
    @objc func settingButtonDidTap() {
        steps.accept(DaruStep.settingIsRequired)
    }
}
