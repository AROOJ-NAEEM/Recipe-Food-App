//
//  FilterExtension.swift
//  Food-Recipie-App
//
//  Created by Dev on 3/19/24.
//

import Foundation
import UIKit

extension FilterViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == timeCollectionView {
            return timeArray.count
        } else if collectionView == rateCollectionView {
            return rateArray.count
        } else if collectionView == categoryCollectionView {
            return categoryArray.count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == timeCollectionView {
            let cell = timeCollectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! TimeCollectionViewCell
            cell.configure(title: timeArray[indexPath.row])
            return cell
        } else if collectionView == rateCollectionView {
            let cell = rateCollectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! RateCollectionViewCell
            cell.configureColor(label: rateArray[indexPath.row])
            return cell
        } else {
            let cell = categoryCollectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! FilterCategoryCollectionViewCell
            cell.configureColor(label: categoryArray[indexPath.row])
            return cell
        }
    }
    
    
}

extension FilterViewController: UISheetPresentationControllerDelegate {
    override var sheetPresentationController: UISheetPresentationController? {
        presentationController as? UISheetPresentationController
    }
}
