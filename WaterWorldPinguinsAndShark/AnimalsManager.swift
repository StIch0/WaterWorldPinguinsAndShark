//
//  AnimalsManager.swift
//  WaterWorldPinguinsAndShark
//
//  Created by Pavel Burdukovskii on 17/05/2018.
//  Copyright © 2018 Pavel Burdukovskii. All rights reserved.
//

import Foundation
import UIKit
class AnimalsManager {
    func getAnimals (comletion: @escaping ([Animals])->Void){
        DispatchQueue.main.asyncAfter(deadline: .now()) {
        comletion(self.mockResponse())
        }
    }
    private func mockResponse()->[Animals]{
        var animals = [Animals]()
        var pCount : Int = 0
        var sCount : Int = 0
        for x in 0...14{
            for y in 0...9 {
                let pos = Position.init(x: x, y: y)
                let rand = arc4random_uniform(3)
                if rand == 0 {
                    if sCount < 30 {
                        animals.append(mockAnimalsObject(direction: .None, color: .red, life: 0, position: pos, title: "Shark", maxLife: 8, stepToEat: 3))
                        sCount+=1
                    }
                    else {
                        animals.append(mockAnimalsObject(direction: .None, color: .lightGray, life: 0, position: pos, title: "Sea", maxLife: 0, stepToEat: 0))
                    }
                }
                else if rand == 1{
                    if pCount < 75  {
                        animals.append(mockAnimalsObject(direction: .None, color: .blue, life: 0, position: pos, title: "Pinguins", maxLife: 3, stepToEat: 0))
                        
                        pCount+=1
                    }
                    else {
                        animals.append(mockAnimalsObject(direction: .None, color: .lightGray, life: 0, position: pos, title: "Sea", maxLife: 0, stepToEat: 0))
                    }
                }
                else {
                    animals.append(mockAnimalsObject(direction: .None, color: .lightGray, life: 0, position: pos, title: "Sea", maxLife: 0, stepToEat: 0))
                }
            }
        }
        return animals
    }
    private func mockAnimalsObject(direction : Direction, color : UIColor, life : Int, position : Position, title : String, maxLife : Int, stepToEat : Int)->Animals{
        let animal = Animals(direction: direction, color: color, life: life, position: position, title: title, maxLife: maxLife, stepToEat: stepToEat)
        return animal
    }
}
