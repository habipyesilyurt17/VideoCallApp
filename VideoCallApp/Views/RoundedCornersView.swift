//
//  RoundedCornersView.swift
//  VideoCallApp
//
//  Created by Habip Yesilyurt on 3.05.2024.
//

import UIKit

final class RoundedCornersView: UIView {
    override func layoutSubviews() {
        super.layoutSubviews()
        roundCorners(.allCorners, radius: 15)
    }
}
