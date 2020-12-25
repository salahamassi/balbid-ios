//
//  Animator.swift
//  MSA
//
//  Created by Salah Amassi on 10/16/20.
//  Copyright © 2020 msa. All rights reserved.
//

import UIKit

typealias Animation = (UICollectionViewCell, IndexPath, UICollectionView) -> Void

final class Animator {

    private var hasAnimatedAllCells = false
    private let animation: Animation

    init(animation: @escaping Animation) {
        self.animation = animation
    }

    func animate(cell: UICollectionViewCell, at indexPath: IndexPath, in collectionView: UICollectionView) {
        guard !hasAnimatedAllCells else {
            return
        }

        animation(cell, indexPath, collectionView)

        hasAnimatedAllCells = collectionView.isLastVisibleCell(at: indexPath)
    }

}
