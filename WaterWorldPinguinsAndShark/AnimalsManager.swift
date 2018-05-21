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
                let rand = arc4random_uniform(2)
                if rand == 0 {
                    if sCount < 8 {
                        //animals.append(mockAnimalsObject(direction: .None, color: .red, life: 0, position: pos, title: "Shark", maxLife: 8, stepToEat: 3, needToEat : false))
//                        animals.append(Shark(direction: .None, color: .red, life: 0, position: pos, title: "Shark", maxLife: 8, isFull: false, stepToEat: 3))
                        animals.append(mockSharksObject(direction: .None, color: .red, life: 0, position: pos, title: "Shark", maxLife: 8, isFull: false, stepToEat: 3))
                        sCount+=1
                    }
                    else {
                        animals.append(mockAnimalsObject(direction: .None, color: .lightGray, life: 0, position: pos, title: "None", maxLife: 0))
                    }
                }
                else if rand == 1{
                    if pCount < 75  {
//                        animals.append(mockAnimalsObject(direction: .None, color: .blue, life: 0, position: pos, title: "Pinguins", maxLife: 3, stepToEat: 0, needToEat : false))
//                        animals.append(Penguins(direction: .None, color: .blue, life: 0, position: pos, title: "Penguins", maxLife: 3))
                        animals.append(mockPenguinsObject(direction: .None, color: .blue, life: 0, position: pos, title: "Penguins", maxLife: 3))
                        pCount+=1
                    }
                    else {
                        animals.append(mockAnimalsObject(direction: .None, color: .lightGray, life: 0, position: pos, title: "None", maxLife: 0))
                    }
                }
                else {
                    animals.append(mockAnimalsObject(direction: .None, color: .lightGray, life: 0, position: pos, title: "None", maxLife: 0))
                }
            }
        }
        return animals
    }
    private func mockPenguinsObject(direction : Direction, color : UIColor, life : Int, position : Position, title : String, maxLife : Int)->Penguins{
        let penguin = Penguins(direction: direction, color: color, life: life, position: position, title: title, maxLife: maxLife)
        return penguin
    }
    private func mockSharksObject(direction: Direction, color: UIColor, life: Int, position: Position, title: String, maxLife: Int, isFull : Bool, stepToEat: Int)->Shark{
        let shark = Shark(direction: direction, color: color, life: life, position: position, title: title, maxLife: maxLife, isFull: isFull, stepToEat: stepToEat)
        return shark
    }
    private func mockAnimalsObject(direction : Direction, color : UIColor, life : Int, position : Position, title : String, maxLife : Int)->Animals{
        let animal = Animals(direction: direction, color: color, life: life, position: position, title: title, maxLife: maxLife)
        return animal
    }
}
