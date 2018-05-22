//
//  Pinguins.swift
//  WaterWorldPinguinsAndShark
//
//  Created by Pavel Burdukovskii on 17/05/2018.
//  Copyright © 2018 Pavel Burdukovskii. All rights reserved.
//

import Foundation
import UIKit
class Penguins : Animals {
    override init(direction: Direction, photo: UIImage, life: Int, position: Position, title: String, maxLife: Int) {
        super.init(direction: direction, photo: photo, life: life, position: position, title: title, maxLife: maxLife)
    }
}
