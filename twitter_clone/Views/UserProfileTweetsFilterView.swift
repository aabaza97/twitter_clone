//
//  UserProfileTweetsFilterView.swift
//  twitter_clone
//
//  Created by Ahmed Abaza on 13/02/2021.
//

import UIKit

private let filterCellReuseId: String = "filterCell"

protocol FilterBarDelegate: class {
    func selectOption(_ view: UICollectionView, byItemAt indexPath: IndexPath) -> Void
    func filter(by filterOption: FilterOptions) -> Void
}

extension FilterBarDelegate {
    func selectOption(_ view: UICollectionView, byItemAt indexPath: IndexPath) -> Void {
        return
    }
    func filter(by filterOption: FilterOptions) -> Void {
        return
    }
}

class UserProfileTweetsFilterView: UIView {
    
    //MARK: -Logic Properties
    weak var delegate: FilterBarDelegate?
    
    //MARK: -UI Properties
    public var filterOptions: [String]? {
        didSet {
            let firstCellIndexPath = IndexPath(item: 0, section: 0)
            self.containerView.reloadData()
            self.containerView.selectItem(at: firstCellIndexPath,
                                          animated: false,
                                          scrollPosition: UICollectionView.ScrollPosition(rawValue: 0))
        }
    }
    
    private lazy var containerView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 0
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.backgroundColor = .white
        view.delegate = self
        view.dataSource = self
        return view
    }()
    
    
    //MARK: -Inits
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: -Selectors
    
    
    //MARK: -Functions
    private func configureView() -> Void {
        self.backgroundColor = .red
        
        //CollectionView Configuration
        self.containerView.register(FilterButtonView.self, forCellWithReuseIdentifier: filterCellReuseId)
        
        
        //Adding SubViews
        self.addSubview(containerView)
        
        //SubViews Configurations
        self.containerView.anchor(top: self.topAnchor,
                    left: self.leftAnchor,
                    bottom: self.bottomAnchor,
                    right: self.rightAnchor)
    }
}


//MARK: -EXT(CollectionView Delegate)
extension UserProfileTweetsFilterView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let delegate = self.delegate else { return }
        guard let filterOption = FilterOptions.init(rawValue: indexPath.row) else { return }
        
        delegate.selectOption(self.containerView, byItemAt: indexPath)
        delegate.filter(by: filterOption)
    }
}

//MARK: -EXT(CollectionView DataSource)
extension UserProfileTweetsFilterView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let filterOptions = filterOptions else { return 0 }
        return filterOptions.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let filterOptions = filterOptions else { return UICollectionViewCell() }
        let filterButtonView: FilterButtonView = collectionView.dequeueReusableCell(withReuseIdentifier: filterCellReuseId, for: indexPath) as! FilterButtonView
        filterButtonView.titleText = filterOptions[indexPath.row]
        return filterButtonView
    }
    
    
}

//MARK: -EXT(CollectionView FlowLayout)
extension UserProfileTweetsFilterView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let filterOptions = filterOptions else { return CGSize(width: 0, height: 0) }
        let filterOptionsCount = CGFloat(filterOptions.count)
        let width = self.frame.width / filterOptionsCount
        return CGSize(width: width,
                      height: 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
