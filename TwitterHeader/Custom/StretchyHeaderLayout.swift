//
//  StretchyHeaderLayout.swift
//  TwitterHeader
//
//  Created by Omar Khodr on 10/8/20.
//

import UIKit

class StretchyHeaderLayout: UICollectionViewFlowLayout {
    
    // we want to modify the attributes of our header component somehow
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        let layoutAttributes = super.layoutAttributesForElements(in: rect)
        
        layoutAttributes?.forEach({ (attributes) in
            if attributes.representedElementKind == UICollectionView.elementKindSectionHeader && attributes.indexPath.section == 0 {
                //header
                guard let collectionView = collectionView else { return }
                
                let contentOffsetY = collectionView.contentOffset.y
                
                //don't do any enlarging if scrolling down
                if contentOffsetY > 0 {
                    return
                }
                
                let width = collectionView.frame.width
                let height = attributes.frame.height - contentOffsetY
                
                attributes.frame = CGRect(x: 0, y: contentOffsetY, width: width, height: height)
            }
        })
        
        return layoutAttributes
    }
    
    //invalidate layout every time it changes so that we recompute the needed height and y positions every time the view's bounds change (i.e. when we hit the top of the scrolling "elasticity"
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }

}
