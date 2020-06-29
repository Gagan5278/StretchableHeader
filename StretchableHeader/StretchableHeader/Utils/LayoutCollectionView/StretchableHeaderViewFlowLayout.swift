//
//  StretchableHeaderViewFlowLayout.swift
//  StretchableHeader
//
//  Created by Gagan  Vishal on 6/29/20.
//

import UIKit

class StretchableHeaderViewFlowLayout: UICollectionViewFlowLayout {
  
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        let attrributes = super.layoutAttributesForElements(in: rect)
        attrributes?.forEach({ (attribute) in
            if attribute.representedElementKind ==  UICollectionView.elementKindSectionHeader {
                guard let collectionView = collectionView  else  {
                    return
                }
                let collectionViewOffsetY = collectionView.contentOffset.y
                if collectionViewOffsetY > 0 {
                    return
                }
                let height = attribute.frame.height - collectionViewOffsetY
                let width = attribute.frame.width
                attribute.frame = CGRect(x: 0.0, y: collectionViewOffsetY, width:
                                        width, height: height)
            }
        })
        return attrributes
    }
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
}
