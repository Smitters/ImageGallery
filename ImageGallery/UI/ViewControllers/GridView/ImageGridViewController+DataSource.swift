//
//  ImageGridViewController+DataSource.swift
//  ImageGallery
//
//  Created by Dmitry Smetankin on 15.06.2021.
//

import UIKit

extension ImageGridViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: PictureCollectionViewCell.reuseIdentifier,
            for: indexPath
        ) as? PictureCollectionViewCell else {
            fatalError("Invalid cell used! Should be PictureCollectionViewCell")
        }
        
        cell.configure(with: images[indexPath.item])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        imageGridViewPresenter.handlePictureSelection(at: indexPath.item)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let smallSide = min(UIScreen.main.bounds.width, UIScreen.main.bounds.height)
        let cellSide = smallSide / Constants.rowsCount - Constants.interItemSpacing * Constants.rowsCount

        return CGSize(width: cellSide, height: cellSide)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return Constants.interItemSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return Constants.interItemSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        willDisplay cell: UICollectionViewCell,
                        forItemAt indexPath: IndexPath) {
        guard indexPath.item >= images.count - Constants.loadMoreItemsOffset else { return }
        imageGridViewPresenter.handleLatestCellsDisplaying()
    }
}

extension ImageGridViewController {
    enum Constants {
        static let interItemSpacing: CGFloat = 8
        static let rowsCount: CGFloat = 2
        static let loadMoreItemsOffset: Int = 4
    }
}
