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
//    var direction : Direction!
//    var color : UIColor!
//    var life : Int = 0
//    var position : Position!
//    var title : String!
//    var maxLife : Int!
//    var stepToEat : Int!
   override init(direction: Direction, color: UIColor, life: Int, position: Position, title: String, maxLife: Int, stepToEat: Int) {
        super.init(direction: direction, color: .red, life: life, position: position, title: "Shark", maxLife: maxLife, stepToEat: stepToEat)
    }
}
