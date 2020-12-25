//
//  CollectionView.swift
//  MSA
//
//  Created by Qamar Nahed on 8/28/20.
//  Copyright © 2020 msa. All rights reserved.
//

import UIKit

extension UICollectionView {

    convenience init (scrollDirection: UICollectionView.ScrollDirection = UICollectionView.ScrollDirection.vertical, itemSize: CGSize? = nil, minimumInteritemSpacing: CGFloat? = nil, minimumLineSpacing: CGFloat? = nil, keyboardDismissMode: UIScrollView.KeyboardDismissMode = .none, isPagingEnabled: Bool = false) {
        let layout = UICollectionViewFlowLayout(scrollDirection: scrollDirection)
        if let itemSize = itemSize {
            layout.itemSize = itemSize
        }
        if let minimumInteritemSpacing = minimumInteritemSpacing {
            layout.minimumInteritemSpacing = minimumInteritemSpacing
        }
        if let minimumLineSpacing = minimumLineSpacing {
            layout.minimumLineSpacing = minimumLineSpacing
        }
        self.init(frame: .zero, collectionViewLayout: layout)
        self.keyboardDismissMode = keyboardDismissMode
        self.isPagingEnabled = isPagingEnabled
        self.backgroundColor = .clear
    }

    /// VisibleCells in the order they are displayed on screen.
    var orderedVisibleCells: [UICollectionViewCell] {
        return indexPathsForVisibleItems.sorted().compactMap { cellForItem(at: $0) }
    }

    /// Gets the currently visibleCells of a section.
    ///
    /// - Parameter section: The section to filter the cells.
    /// - Returns: Array of visible UICollectionViewCells in the argument section.
    func visibleCells(in section: Int) -> [UICollectionViewCell] {
        return visibleCells.filter { indexPath(for: $0)?.section == section }
    }

    func isLastVisibleCell(at indexPath: IndexPath) -> Bool {
        guard let lastCell = visibleCells.last else { return false }
        guard let lastCellIndexPath = self.indexPath(for: lastCell) else { return false }
        return indexPath == lastCellIndexPath
    }

    @discardableResult
    func register(cells: (cellClass: UICollectionViewCell.Type, cellId: String) ...) -> UICollectionView {
        for cell in cells {
            register(cell.cellClass, forCellWithReuseIdentifier: cell.cellId)
        }
        return self
    }

    func register(cells: (nibName: String, cellId: String) ...) {
        cells.forEach {
            register(UINib(nibName: $0.nibName, bundle: nil), forCellWithReuseIdentifier: $0.cellId)
        }
    }

    @discardableResult
    func register(headers: (nibName: String, headerId: String) ...) -> UICollectionView {
        for header in headers {
            let nib = UINib(nibName: header.nibName, bundle: .main)
            register(nib,
                     forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: header.headerId)
        }
        return self
    }
}
