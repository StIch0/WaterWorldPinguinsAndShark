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
    private var direction : [Direction]! = [.Top, .Down, .Left, .Right, .TopLeft, .TopRight, .DownLeft, .DownRight]
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
    func checkPosition (x : Int, y : Int)->Bool{
        return x >= 0 && y >= 0 && x < 15 && y < 10
    }
    func setPosition (_ animal : Animals, x: Int , y : Int){
        animal.position.x = x
        animal.position.y = y
    }
    
    func setLife(animal : Animals){
        animal.life += 1
    }
    func findThePinguins (animal : Animals)->(Bool, Int, Int){
        var result : Bool = false
        for dir in direction{
            let pos = chooseDirection(dir: dir)
            let newX = animal.position.x + pos.0
            let newY = animal.position.y + pos.1
            if checkPosition(x: newX, y: newY){
                if (animals[10 * newX + newY].title == "Pinguins"){
                    result = true
                    return (result, newX,newY)
                }
                else {
                    continue
                }
            }
        }
        return (false,0,0)
    }
    func makeStep(_ animal : Animals){
        var oldX : Int = animal.position.x
        var oldY : Int = animal.position.y
        var newX : Int = oldX
        var newY : Int = oldY
        let index : Int = Int(arc4random_uniform(UInt32(direction.count)))
        animal.direction = direction[index]
        let newPos = chooseDirection(dir: animal.direction)
        newX = newPos.0 + oldX
        newY = newPos.1 + oldY
        if checkPosition(x: newX, y: newY) && animals[10 * newX + newY].title == "Sea" {
            setPosition(animal, x: newX, y: newY)
            setLife(animal: animal)
            animals.swapAt(10 * oldX + oldY, 10 * animal.position.x + animal.position.y)
            oldX = 0
            oldY = 0
        }
    }
    func replace (x : Int, y: Int){
        let animal = animals[10 * x + y]
        animal.color = .lightGray
        animal.direction = .None
        animal.life = 0
        animal.maxLife = 0
        animal.position = Position(x: x, y: y)
        animal.stepToEat = 0
        animal.title = "Sea"
    }
    func eat(animal : Animals){
        let check = findThePinguins(animal: animal)
        if check.0 {
//            animals[10 * check.1 + check.2].color =
//            animals.insert(Animals.init(direction: .None, color: .lightGray, life: 0, position: Position(x: check.1, y: check.2) , title: "Sea", maxLife: 0, stepToEat: 0), at: (10 * check.1 + check.2))
            replace(x: check.1, y: check.2)
//            setPosition(animal, x: check.1, y: check.2)
            animals.swapAt((10 * animal.position.x + animal.position.y), (10 * check.1 + check.2))
            print("title = ", animals[10 * check.1 + check.2].title)
        }else {
            makeStep(animal)
        }
    }
    func chooseDirection(dir : Direction)->(Int,Int){
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
    
    func move (animals  : [Animals]){
        for animal in animals {
            if animal.title != "Sea"{
                if animal.title == "Shark"{
                    eat(animal: animal)
                }else {
                    makeStep(animal)
                }
            }
        }
    }
    func op(){
        cellsArray.removeAll()
             move(animals: animals)
            for animal in animals{
                cellsArray.append(StartViewControllerCellViewModel(animal: animal))
            }
//        completion()

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
