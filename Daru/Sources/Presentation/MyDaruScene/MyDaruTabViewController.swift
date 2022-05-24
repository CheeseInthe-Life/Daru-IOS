//
//  MyDaruTabViewController.swift
//  Daru
//
//  Created by 재영신 on 2022/05/21.
//

import UIKit
import SnapKit
import Then
import Tabman
import Pageboy

final class MyDaruTabViewController: TabmanViewController {
    
    private let tabs: [(name: String, viewController: UIViewController)]
    
    init(tabs: [(name: String, viewController: UIViewController)]) {
        self.tabs = tabs
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.tabs = []
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //let bar = TMBar.ButtonBar()
        
        let bar = TMBarView<TMHorizontalBarLayout, TMLabelBarButton, TMBlockBarIndicator>()
        bar.layout.transitionStyle = .snap // Customize
        bar.layout.contentMode = .fit
        bar.backgroundView.style = .flat(color: .brown3!.withAlphaComponent(0.3))
        bar.indicator.backgroundColor = .white
        bar.indicator.layer.borderWidth = 1.0
        bar.indicator.layer.borderColor = UIColor.lineBrown?.cgColor
        bar.buttons.customize { button in
            button.selectedFont = .notoSansKR(.bold, size: 16.0)
            button.selectedTintColor = .tit_brwon
            button.font = .notoSansKR(.regular, size: 16.0)
        }
        
        bar.indicator.cornerStyle = .eliptical
        self.dataSource = self
        // Add to view
        addBar(bar, dataSource: self, at: .top)
    }
}

extension MyDaruTabViewController: PageboyViewControllerDataSource, TMBarDataSource {
    func numberOfViewControllers(in pageboyViewController: PageboyViewController) -> Int {
        return tabs.count
    }
    
    func viewController(for pageboyViewController: PageboyViewController,
                        at index: PageboyViewController.PageIndex) -> UIViewController? {
        return tabs[index].viewController
    }
    
    func defaultPage(for pageboyViewController: PageboyViewController) -> PageboyViewController.Page? {
        return nil
    }
    
    func barItem(for bar: TMBar, at index: Int) -> TMBarItemable {
        return TMBarItem(title: tabs[index].name)
    }
}
