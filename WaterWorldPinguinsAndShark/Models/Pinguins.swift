//
//  Pinguins.swift
//  WaterWorldPinguinsAndShark
//
//  Created by Pavel Burdukovskii on 17/05/2018.
//  Copyright © 2018 Pavel Burdukovskii. All rights reserved.
//

import Foundation
import UIKit
class Pinguins : Animals {
    override init(direction: Direction, color: UIColor, life: Int, position: Position, title: String, maxLife: Int, stepToEat: Int) {
        super.init(direction: direction, color: .blue, life: life, position: position, title: "Pinguins", maxLife: maxLife, stepToEat: stepToEat)
    }
}
