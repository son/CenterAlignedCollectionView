//
//  FlowLayout.swift
//  CenterAlignedCollectionView
//
//  Created by Takeru Sato on 2019/03/03.
//  Copyright © 2019 son. All rights reserved.
//

import UIKit

class FlowLayout: UICollectionViewFlowLayout {
    
    private var isSetupDone = false
    
    override func prepare() {
        super.prepare()
        if !isSetupDone {
            setup()
            isSetupDone.toggle()
        }
    }
    
    private func setup() {
        scrollDirection = .horizontal
        minimumLineSpacing = 10
        guard let collectionView = collectionView else { return }
        itemSize = CGSize(width: collectionView.frame.width - 40, height: collectionView.frame.height)
        collectionView.decelerationRate = UIScrollView.DecelerationRate.fast
        sectionInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
    }
    
    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
        guard let collectionView = collectionView else { return .zero }
        let layoutAttributes = layoutAttributesForElements(in: collectionView.bounds)
        let centerOffset = collectionView.bounds.size.width / 2
        let offsetWithCenter = proposedContentOffset.x + centerOffset
        guard let contestAttribute = layoutAttributes else { return .zero }
        let att = contestAttribute.sorted(by: { abs($0.center.x - offsetWithCenter) < abs($1.center.x - offsetWithCenter) }).first ?? UICollectionViewLayoutAttributes()
        return CGPoint(x: att.center.x - centerOffset, y: 0)
    }
}
