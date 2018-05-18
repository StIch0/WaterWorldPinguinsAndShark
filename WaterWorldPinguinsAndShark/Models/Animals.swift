//
//  Animals.swift
//  WaterWorldPinguinsAndShark
//
//  Created by Pavel Burdukovskii on 17/05/2018.
//  Copyright © 2018 Pavel Burdukovskii. All rights reserved.
//

import Foundation
import  UIKit
class Animals {
    var direction : Direction
    var color : UIColor
    var life : Int
    var position : Position
    var title : String
    var maxLife : Int
    var stepToEat : Int
    init (direction : Direction, color : UIColor, life : Int, position : Position, title : String, maxLife : Int, stepToEat : Int){
        self.direction = direction
        self.color = color
        self.life = life
        self.position = position
        self.title = title
        self.maxLife = maxLife
        self.stepToEat = stepToEat
    }
}
