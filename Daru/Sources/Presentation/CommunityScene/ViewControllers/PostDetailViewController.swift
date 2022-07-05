//
//  PostDetailViewController.swift
//  Daru
//
//  Created by 재영신 on 2022/05/31.
//

import UIKit
import SnapKit
import Then
import ReactorKit
import Differentiator

final class PostDetailViewController: BaseViewController, View {
    
    private let mainCollectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: .init()
    ).then {
        $0.register(PostContentCell.self, forCellWithReuseIdentifier: PostContentCell.identifier)
        $0.register(PostCommentCell.self, forCellWithReuseIdentifier: PostCommentCell.identifier)
        $0.register(
            PostCommentHeaderView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: PostCommentHeaderView.identifier
        )
        $0.showsVerticalScrollIndicator = false
        $0.backgroundColor = .systemBackground
    }
    
    private let titleView = UILabel().then {
        $0.font = .notoSansKR(.bold, size: 18.0)
        $0.textColor = .tit_brwon
        $0.text = "다루 커뮤니티"
    }
    
    private let bottomView = UIView().then {
        $0.layer.cornerRadius = 5.0
        $0.layer.borderWidth = 1.0
        $0.layer.borderColor = UIColor.gray5?.cgColor
    }
    
    private let inputTextView = UITextView().then {
        $0.textColor = .gray2
        $0.text = "댓글을 입력하세요"
        $0.font = .notoSansKR(.bold, size: 14.0)
        
        //$0.contentInset = .init(top: 0, left: 10.0, bottom: 0, right: 0)
    }
    
    private let sendButton = UIButton().then {
        $0.setImage(Constant.sendIcon, for: .normal)
    }
    
    private let anonymityLabel = UILabel().then {
        $0.text = "익명 여부"
        $0.font = .notoSansKR(.regular, size: 14.0)
        $0.textColor = .gray1
    }
    
    init(reactor: PostDetailReactor) {
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
        
        [
            inputTextView,
            sendButton
        ].forEach {
            bottomView.addSubview($0)
        }
        
        [
            bottomView,
            mainCollectionView,
            anonymityLabel
        ].forEach {
            view.addSubview($0)
        }
        
        inputTextView.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(10.0)
            make.trailing.equalTo(sendButton.snp.leading).offset(-8.0)
            make.top.bottom.equalToSuperview().inset(5.0)
            make.height.equalTo(40.0)
        }
        inputTextView.delegate = self
        
        sendButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(5.0)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(40.0)
        }
        
        anonymityLabel.snp.makeConstraints { make in
            make.bottom.equalTo(bottomView.snp.top).offset(-12.0)
            make.trailing.equalToSuperview().inset(18.0)
        }
        
        bottomView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20.0)
            make.bottom.equalToSuperview().inset(30.0)
        }
        
        mainCollectionView.snp.makeConstraints { make in
            make.leading.top.trailing.equalToSuperview()
            make.bottom.equalTo(anonymityLabel.snp.top).offset(-15.0)
        }
        mainCollectionView.collectionViewLayout = createLayout()
        
        navigationItem.titleView = titleView
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardDidHide), name: UIResponder.keyboardDidHideNotification, object: nil)
        
        
    }
    
    func bind(reactor: PostDetailReactor) {
        
        Observable.just(
            [
                SectionModel(model: "", items: ["a"]),
                SectionModel(model: "", items: ["a","b","c"])
            ]
        ).bind(to: mainCollectionView.rx.items(dataSource: PostDetailDataSource.dataSource()))
            .disposed(by: disposeBag)
    }
}

private extension PostDetailViewController {
    
    func createLayout() -> UICollectionViewCompositionalLayout {
        return .init {
            [weak self] section, environment -> NSCollectionLayoutSection? in
            switch section {
            case 0:
                return self?.createPostContentSection()
            case 1:
                return self?.createPostCommentSection()
            default:
                return nil
            }
        }
    }
    
    func createPostContentSection() -> NSCollectionLayoutSection {
        //item
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(200.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        //group
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(200.0))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 1)
        //section
        let section = NSCollectionLayoutSection(group: group)
        return section
    }
    
    func createPostCommentSection() -> NSCollectionLayoutSection {
        //item
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(200.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        //group
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(200.0))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 1)
        //section
        let section = NSCollectionLayoutSection(group: group)
        section.boundarySupplementaryItems = [
            createPostCommentSectionHeader()
        ]
        return section
    }
    
    private func createPostCommentSectionHeader() -> NSCollectionLayoutBoundarySupplementaryItem {
        
        //Section Header 사이즈
        let layoutSectionHeaderSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(46.0))
        
        //Section Header layout
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: layoutSectionHeaderSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .topLeading)
        return sectionHeader
    }
}

extension PostDetailViewController{
    @objc func keyboardWillShow(noti : Notification){
        let notiInfo = noti.userInfo!
        let keyboardFrame = notiInfo[UIResponder.keyboardFrameEndUserInfoKey] as! CGRect
        let animationDuration = notiInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as! TimeInterval
        
        UIView.animate(withDuration: animationDuration) {
            [weak self] in
            guard let self = self else {return}
            self.bottomView.snp.updateConstraints { make in
                make.bottom.equalToSuperview().inset(keyboardFrame.size.height + 8.0)
            }
            self.view.layoutIfNeeded()
        }
    }
    @objc func keyboardDidHide(noti : Notification){
        let notiInfo = noti.userInfo!
        let animationDuration = notiInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as! TimeInterval
        
        UIView.animate(withDuration: animationDuration) {
            [weak self] in
            self?.bottomView.snp.updateConstraints { make in
                make.bottom.equalToSuperview().inset(30.0)
            }
            self?.view.layoutIfNeeded()
        }
    }
}

extension PostDetailViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == .gray2 {
            textView.text = nil
            textView.textColor = .black
        }
        
    }
    // TextView Place Holder
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "댓글을 입력하세요"
            textView.textColor = .gray2
        }
    }
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        guard let str = textView.text else { return true }
        let newLength = str.count + text.count - range.length
        return newLength <= 50
    }
    
    func textViewDidChange(_ textView: UITextView) {
        print(textView.contentSize.height)
        if textView.contentSize.height <= 40{
            inputTextView.snp.updateConstraints { make in
                make.height.equalTo(40)
            }
        }else if textView.contentSize.height >= 100{
            inputTextView.snp.updateConstraints { make in
                make.height.equalTo(100)
            }
        }else{
            inputTextView.snp.updateConstraints { make in
                make.height.equalTo(textView.contentSize.height)
            }
        }
    }
}
