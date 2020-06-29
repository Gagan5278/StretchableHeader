//
//  ViewController.swift
//  StretchableHeader
//
//  Created by Gagan  Vishal on 6/29/20.
//

import UIKit

class StretchableHeaderViewController: UICollectionViewController {
    //number of items. Constant value for demo
    private let numberOfItemsInSection = 20
    //cell padding constant
    private let cellPaddiingConstant: CGFloat = 20.0
    //cell height consant
    private let cellHeightConstant: CGFloat =  45.0
    //Cell Reusable identifier
    private let cellReusableIdentifier = "cellIdentifier"
    //CollectinView Header identifier
    private let collectionHeaderIdentifier = "headerViewIdentifier"
    //CollectionHeeaderReusableView Object
    private var headerView: CollectionHeeaderReusableView?
    //MARK:- View Controller life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        //1. UICollectionViewCell setup
        self.collectionViewSetup()
        //2. CollectionView Header Setup
        self.collectinHeaderSetup()
    }
    
    //MARK:- CollectioonView Setup
    fileprivate func collectionViewSetup() {
        self.collectionView.contentInsetAdjustmentBehavior = .never
        self.collectionView.backgroundColor = .white
        self.collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: self.cellReusableIdentifier)
        if let layout = collectionViewLayout as? UICollectionViewFlowLayout  {
            layout.sectionInset = .init(top: self.cellPaddiingConstant, left: self.cellPaddiingConstant, bottom: self.cellPaddiingConstant, right: self.cellPaddiingConstant)
        }
    }
    
    //MARK:- Collection Header setup
    fileprivate func collectinHeaderSetup() {
        self.collectionView.register(CollectionHeeaderReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: self.collectionHeaderIdentifier)
    }
}

//MARK:- CollectionView Data Source
extension StretchableHeaderViewController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.numberOfItemsInSection
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.cellReusableIdentifier, for: indexPath)
        cell.backgroundColor = .red
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        self.headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: self.collectionHeaderIdentifier, for: indexPath) as? CollectionHeeaderReusableView
        return headerView!
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        let image = #imageLiteral(resourceName: "headerImageView") //get image headerImageView and return size as pr device width
        return .init(width: self.view.frame.width, height: (self.view.frame.width * CGFloat(image.size.height/image.size.width) ))
    }
    
}

//MARK:- ScrollView Delegate
extension StretchableHeaderViewController {
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if let headerView = self.headerView {
          let contentOffsetY =  scrollView.contentOffset.y
            if contentOffsetY > 0 { return }
            headerView.animateProperty.fractionComplete = abs(contentOffsetY/100.0)
        }
    }
}
//MARK:- UICollectionViewDelegateFlowLayout
extension StretchableHeaderViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: self.view.frame.width - 2*self.cellPaddiingConstant, height: self.cellHeightConstant)
    }
}
