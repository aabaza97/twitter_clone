//
//  SearchViewController.swift
//  twitter_clone
//
//  Created by Ahmed Abaza on 03/02/2021.
//

import UIKit

private let headerReuseId: String = "exploreHeader"
private let trendingReuseId: String = "trendingCell"

class ExploreViewController: UICollectionViewController {

    //MARK: -Properties
    
    private lazy var sideMenuButton: UIButton = {
        let btn = UIButton(type: .system)
        let imgConfig = UIImage.SymbolConfiguration(weight: .bold)
        let img = UIImage(systemName: "line.horizontal.3", withConfiguration: imgConfig)
        btn.setImage(img , for: .normal)
        btn.tintColor = .twitterBlue
        btn.addTarget(self, action: #selector(toggleSideMenu), for: .touchUpInside)
        return btn
    }()
    
    private lazy var settingsButton: UIButton = {
        let btn = UIButton(type: .system)
        let imgConfig = UIImage.SymbolConfiguration(weight: .bold)
        let img = UIImage(systemName: "gearshape", withConfiguration: imgConfig)
        btn.setImage(img , for: .normal)
        btn.tintColor = .twitterBlue
        btn.addTarget(self, action: #selector(toggleSideMenu), for: .touchUpInside)
        return btn
    }()
    
    private lazy var titleView: UIView = {
        let view = ExploreTitleView()
        view.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(searchViewPressed))
        view.addGestureRecognizer(tapGesture)
        return view
    }()
    
    //MARK: -Overrides
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureView()
    }
    
    //MARK: -Selectors
    @objc func toggleSideMenu() -> Void {
        print("SideMenu toggled!!")
    }
    @objc func searchViewPressed() -> Void {
        let searchController = SearchViewController()
        self.navigationController?.pushViewController(searchController, animated: false)
    }
    
    //MARK: -Fucntions
    
    func configureView() -> Void {
        self.view.backgroundColor = .white
        
        //navigation controller configuration
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.topItem?.titleView = titleView
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: sideMenuButton)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: settingsButton)
        
        
        //collectionview configuration
//        self.collectionView.frame = self.view.frame
        self.collectionView.backgroundColor = .white
        self.collectionView.contentInsetAdjustmentBehavior = .never
        self.collectionView.register(TrendingCell.self,
                                     forCellWithReuseIdentifier: trendingReuseId)
        self.collectionView.register(ExploreHeaderView.self,
                                     forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                     withReuseIdentifier: headerReuseId)
        
    }

}


//MARK: -EXT(Controller)
extension ExploreViewController {
    //Header
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard indexPath.section == 0 else { return UICollectionReusableView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 10)) }
        let headerView: ExploreHeaderView = self.collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerReuseId, for: indexPath) as! ExploreHeaderView
    
        return headerView
    }
    
    //Number of sections
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    
    //Number of items
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    //Cells
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: trendingReuseId, for: indexPath) as! TrendingCell
        return cell
    }
    
}


//MARK: -EXT(FlowLayout Delegate)
extension ExploreViewController: UICollectionViewDelegateFlowLayout {
    //Header Size
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        guard section == 0 else { return CGSize(width: self.view.frame.width, height: 0) }
        return CGSize(width: self.view.frame.width, height: 250)
    }
    
    
    //Item Size
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.size.width, height: 90)
    }
    
    //Item Spacing
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
}
