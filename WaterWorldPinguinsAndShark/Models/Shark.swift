//
//  Shark.swift
//  WaterWorldPinguinsAndShark
//
//  Created by Pavel Burdukovskii on 17/05/2018.
//  Copyright © 2018 Pavel Burdukovskii. All rights reserved.
//

import Foundation
import  UIKit
class Shark : Animals {
    var isFull : Bool = false
    var stepToEat : Int = 0
    init(direction: Direction, color: UIColor, life: Int, position: Position, title: String, maxLife: Int, isFull : Bool, stepToEat: Int) {
        super.init(direction: direction, color: .red, life: life, position: position, title: "Shark", maxLife: maxLife)
        self.isFull = isFull
        self.stepToEat = stepToEat

    }
}
