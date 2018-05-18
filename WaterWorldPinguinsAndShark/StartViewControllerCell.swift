//
//  StartViewControllerCell.swift
//  WaterWorldPinguinsAndShark
//
//  Created by Pavel Burdukovskii on 17/05/2018.
//  Copyright © 2018 Pavel Burdukovskii. All rights reserved.
//

import Foundation
import UIKit
class StartViewControllerCell : UICollectionViewCell  {
   weak var viewModel : StartViewControllerCellViewModel! {
        didSet {
            backgroundColor = viewModel.color
            busy = viewModel.busy
            accessibilityLabel = viewModel.title
        }
    }
    var busy : Bool!
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
