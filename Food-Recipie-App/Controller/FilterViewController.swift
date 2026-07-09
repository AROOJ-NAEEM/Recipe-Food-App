//
//  FilterViewController.swift
//  Food-Recipie-App
//
//  Created by Dev on 3/18/24.
//

import UIKit

class FilterViewController: UIViewController {

    var timeArray: [String] = ["All", "Newest", "Oldest"]
    var rateArray: [String] = ["5 ⭐️", "4 ⭐️", "3 ⭐️", "2 ⭐️", "1 ⭐️"]
    var categoryArray: [String] = ["All", "Cereal", "Vegetables", "Dinner", "Chinese", "Local Dish", "Fruit", "BreakFast", "Spanish", "Lunch"]
    weak var filterDelegate: FilterButtonDelegate?
    @IBOutlet weak var categoryCollectionView: UICollectionView!
    @IBOutlet weak var timeCollectionView: UICollectionView!
    @IBOutlet weak var rateCollectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        sheetPresentationController?.delegate = self
        sheetPresentationController?.selectedDetentIdentifier = .medium
        sheetPresentationController?.prefersGrabberVisible = true
        sheetPresentationController?.detents = [.medium(), .large()]
        
        timeCollectionView.dataSource = self
        timeCollectionView.register(UINib(nibName: "TimeCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "Cell")
        
        rateCollectionView.dataSource = self
        rateCollectionView.register(UINib(nibName: "RateCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "Cell")
        
        categoryCollectionView.dataSource = self
        categoryCollectionView.register(UINib(nibName: "FilterCategoryCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "Cell")
    }
    
    @IBAction func filterBtnPressed(_ sender: UIButton) {
        filterDelegate?.filterButtonPressed()
        self.dismiss(animated: true)
    }
    
}
