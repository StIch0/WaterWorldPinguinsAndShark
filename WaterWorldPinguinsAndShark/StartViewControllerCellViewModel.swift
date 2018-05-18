//
//  StartViewControllerCellViewModel.swift
//  WaterWorldPinguinsAndShark
//
//  Created by Pavel Burdukovskii on 17/05/2018.
//  Copyright © 2018 Pavel Burdukovskii. All rights reserved.
//

import Foundation
import UIKit
class StartViewControllerCellViewModel {
    var color : UIColor
    var busy : Bool = false
    var title : String = ""
    required init (animal : Animals){
        color = animal.color
        title = animal.title
    }
}
