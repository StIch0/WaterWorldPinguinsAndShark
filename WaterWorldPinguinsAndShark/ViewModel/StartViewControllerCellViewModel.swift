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
    var busy : Bool = false
    var title : String = ""
    var photo : UIImage!
    required init (animal : Animals){
        photo = animal.photo
        title = animal.title
    }
}
