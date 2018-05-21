//
//  StartViewModel.swift
//  WaterWorldPinguinsAndShark
//
//  Created by Pavel Burdukovskii on 17/05/2018.
//  Copyright © 2018 Pavel Burdukovskii. All rights reserved.
//

import Foundation
class StartViewModel {
    init(animalsManager : AnimalsManager) {
        self.animalsManager = animalsManager
    }
    var animalsManager : AnimalsManager!
    private var cellsArray = [StartViewControllerCellViewModel]()
    private var animals : [Animals]!
    private var direction : [Direction]! =
        [.Top, .Down, .Left, .Right, .TopLeft, .TopRight, .DownLeft, .DownRight]
    func updateData(complection: @escaping ()->Void ){
        cellsArray.removeAll()
        animalsManager.getAnimals(comletion: {animals in
            self.animals = animals
            for animal in animals {
                self.cellsArray.append(StartViewControllerCellViewModel(animal: animal))
            }
            complection()
        })
    }
    private func checkPosition (x : Int, y : Int)->Bool{
        return x >= 0 && y >= 0 && x < 15 && y < 10
    }

 
    private  func findTheObject (animal : Animals, title: String)->(Bool, Int, Int){
        var result : Bool = false
            for dir in direction {
                let pos = chooseDirection(dir: dir)
                let newX = animal.position.x + pos.0
                let newY = animal.position.y + pos.1
                    if checkPosition(x: newX, y: newY){
                        if animals[10 * newX + newY].title == title{
                            result = true
                            return (result, newX, newY)
                        }
                        else {
                            continue
                        }
                    }
            }
        return (false, 0,0)
    }
    private  func reproduction(animal : Animals){
            let findPlace = findTheObject(animal: animal, title : "None")
            if findPlace.0 {
                if animal.title == "Shark"{
                    animals[10 * findPlace.1 + findPlace.2] = Shark(direction: .None, color: .red, life: 0, position: Position(x: findPlace.2, y: findPlace.2), title: "Shark", maxLife: 8, isFull: false, stepToEat: 3)
                    animal.life = 0
                }
                else if animal.title == "Penguins"{
                    animals[10 * findPlace.1 + findPlace.2] = Penguins(direction: .None, color: .blue, life: 3, position: Position(x: findPlace.2, y: findPlace.2), title: "Penguins", maxLife: 3)
                    animal.life = 0
                }
//                animals[10 * findPlace.1 + findPlace.2] = Animals(direction: .None, color: animal.color, life: 0, position: Position(x: findPlace.1, y: findPlace.2), title: animal.title, maxLife: animal.maxLife, stepToEat: animal.stepToEat)
                
        }
    }
    
    
    private func dead(animal : Shark){
         if !(animal.isFull){
            animals[10 * animal.position.x + animal.position.y].color = .lightGray
            animals[10 * animal.position.x + animal.position.y].title = "None"
            animals[10 * animal.position.x + animal.position.y].life = 0
            animals[10 * animal.position.x + animal.position.y].direction = .None
            animals[10 * animal.position.x + animal.position.y].maxLife = 0
//            animals[10 * animal.position.x + animal.position.y].stepToEat = 0
            
         }else {
            animal.isFull = false
        }
    }
    private func makeStep(_ animal : Animals){
        print("\(animal.life) == \(animal.maxLife) is \(animal.title)")
        if animal.life == animal.maxLife {
            reproduction(animal: animal)
            return
        }
        if animal.life % 3 == 0 && animal.life != 0 && animal.title == "Shark"{
            dead(animal: animal as! Shark)
            return
        }
        let oldX : Int = animal.position.x
        let oldY : Int = animal.position.y
        var newX : Int = oldX
        var newY : Int = oldY
        let index : Int = Int(arc4random_uniform(UInt32(direction.count)))
        animal.direction = direction[index]
        let newPos = chooseDirection(dir: animal.direction)
        newX = newPos.0 + oldX
        newY = newPos.1 + oldY
        if checkPosition(x: newX, y: newY) && animals[10 * newX + newY].title == "None" {
            
            if animal.title == "Shark"{
                animals[10 * newX + newY] = Shark(direction: animal.direction, color: animal.color, life: animal.life + 1, position: Position(x : newX, y: newY), title: animal.title, maxLife: 8, isFull: (animal as! Shark).isFull, stepToEat: (animal as! Shark).stepToEat)
            }else
                if animal.title == "Penguins"{
                 animals[10 * newX + newY] = Penguins(direction: animal.direction, color: animal.color, life: animal.life + 1, position: Position(x : newX, y: newY), title: animal.title, maxLife: 3)
            }
//
            
            //Remake
//            animal.life += 1
//            animal.position = Position(x: newX, y: newY)
//            animals[10 * newX + newY] = Animals(animal: animal)
            
//            print("animal = ", animal.life, animal.title)
            animals[10 * oldX + oldY].title = "None"
            animals[10 * oldX + oldY].color = .lightGray
            animals[10 * oldX + oldY].life = 0
            animals[10 * oldX + oldY].direction = .None
            animals[10 * oldX + oldY].maxLife = 0
         //   animals[10 * oldX + oldY].stepToEat = 0
            
        }
        else {
            animal.life += 1
        }
    }
    
   private  func eat(animal : Animals){
        DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
            let check = self.findTheObject(animal: animal, title: "Penguins")
            if check.0 {
                self.animals[check.1*10 + check.2] = Shark(
                    direction: animal.direction,
                    color: animal.color,
                    life: animal.life + 1,
                    position: Position(x: check.1, y: check.2),
                    title: animal.title,
                    maxLife: 8,
                    isFull: true,
                    stepToEat: 3)
                // self.animals[check.1*10 + check.2] = Animals(animal: animal)
                // self.animals[check.1*10 + check.2].position = Position(x: check.1, y: check.2)
                
                
                
                self.animals[animal.position.x*10 + animal.position.y].title = "None"
                self.animals[animal.position.x*10 + animal.position.y].color = .lightGray
                self.animals[animal.position.x*10 + animal.position.y].life = 0
                self.animals[animal.position.x*10 + animal.position.y].direction = .None
                self.animals[animal.position.x*10 + animal.position.y].maxLife = 0
             // self.animals[animal.position.x*10 + animal.position.y].stepToEat = 0
             // animals[animal.position.x*10 + animal.position.y].position = Position(x: animal.position.x, y: animal.position.y)
            }
            else {
                self.makeStep(animal)
            }
        })
    }
    private func chooseDirection(dir : Direction)->(Int,Int){
        var newX : Int  = 0
        var newY : Int = 0
        switch dir{
        case .Top:
            newX -= 1; newY += 0;return(newX,newY)
        case .Down:
            newX += 1; newY += 0;return(newX,newY)
        case .Left:
            newX += 0; newY -= 1;return(newX,newY)
        case .Right:
            newX += 0; newY += 1;return(newX,newY)
        case .TopLeft:
            newX -= 1; newY -= 1;return(newX,newY)
        case .TopRight:
            newX -= 1; newY += 1;return(newX,newY)
        case .DownLeft:
            newX += 1; newY -= 1;return(newX,newY)
        case .DownRight:
            newX += 1; newY += 1;return(newX,newY)
        case .None: return(0,0)
        }
    }
    
    private func move (animals  : [Animals]){
        for animal in animals {
            if animal.title != "None"{
                if animal.title == "Shark"{
                    eat(animal: animal)
                    
                }else {
                    makeStep(animal)
                }
            }
        }
    }
    func runStep(){

        var kk : Int = 0
        for animal in animals {
            if animal.title == "Shark" {
                kk += 1;
            }
        }
        var kkk : Int = 0
        for animal in animals {
            if animal.title == "Penguins" {
                kkk += 1;
            }
        }
        var kkkk : Int = 0
        for animal in animals {
            if animal.title == "None" {
                kkkk += 1;
            }
        }
        print ("kkkkkkkk", kk, kkk,kkkk, kk + kkk + kkkk)
        
        cellsArray.removeAll()
        move(animals: animals)
        for animal in animals{
            cellsArray.append(StartViewControllerCellViewModel(animal: animal))
        }
    }
    func numberOfAnimals ()->Int{
        return cellsArray.count
    }
    func cellsViewModel(index : Int)->StartViewControllerCellViewModel?{
        guard index < numberOfAnimals() else{
        return nil
        }
        return cellsArray[index]
    }
    
    
}
