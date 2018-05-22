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
            picture.image = viewModel.photo
            busy = viewModel.busy
            accessibilityLabel = viewModel.title
        }
    }
    var picture : UIImageView!
    var busy : Bool!
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        if #available(iOS 9.0, *) {
            setUpView()
        } else  if #available(iOS 10.0, *) {
            setUpView()
        }
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    @available(iOS 9.0, *)
    private func setUpView(){
        picture = UIImageView()
        addSubview(picture)
        picture.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            picture.topAnchor.constraint(equalTo: topAnchor),
            picture.bottomAnchor.constraint(equalTo: bottomAnchor),
            picture.leftAnchor.constraint(equalTo: leftAnchor),
            picture.rightAnchor.constraint(equalTo: rightAnchor)
            ])
        
        
    }
}
