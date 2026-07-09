//
//  TimeCollectionViewModel.swift
//  Food-Recipie-App
//
//  Created by Dev on 3/22/24.
//

import Foundation

class TimeCollectionViewModel {
    func storeTimeLabelVlaue(timeLabel: String) {
        FilterManager.shared.filter.time = timeLabel
    }
}
