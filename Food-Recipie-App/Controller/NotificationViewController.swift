//
//  NotificationViewController.swift
//  Food-Recipie-App
//
//  Created by Dev on 3/11/24.
//

import UIKit

class NotificationViewController: UIViewController {

    private let databaseManager = DatabaseManager.shared
    var viewModel: NotificationViewModel!
    
    @IBOutlet weak var todayActivityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var yesterdayActivityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var todayCollectionView: UICollectionView!
    @IBOutlet weak var yesterdayCollectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        setupCollectionView()
        viewModel = NotificationViewModel(databaseManager: databaseManager)
        fetchNotifications()
    }
    
    func setupUI() {
        todayActivityIndicator.startAnimating()
        yesterdayActivityIndicator.startAnimating()
    }
    
    func setupCollectionView() {
        yesterdayCollectionView.dataSource = self
        yesterdayCollectionView.register(UINib(nibName: "YesterdayCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "Cell")
        
        todayCollectionView.dataSource = self
        todayCollectionView.register(UINib(nibName: "NotificationCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "Cell")
    }
    
    private func fetchNotifications() {
        viewModel.fetchNotifications { [weak self] in
            self?.updateCollectionView()
            self?.yesterdayActivityIndicator.stopAnimating()
            self?.yesterdayActivityIndicator.isHidden = true
            self?.todayActivityIndicator.stopAnimating()
            self?.todayActivityIndicator.isHidden = true
        }
    }
    
    @IBAction func allBtnPressed(_ sender: UIButton) {
        viewModel.filterState = .all
        updateCollectionView()
    }
    
    @IBAction func readBtnPressed(_ sender: UIButton) {
        viewModel.filterState = .read
        updateCollectionView()
    }
    
    @IBAction func unreadBtnPressed(_ sender: UIButton) {
        viewModel.filterState = .unread
        updateCollectionView()
    }
}
