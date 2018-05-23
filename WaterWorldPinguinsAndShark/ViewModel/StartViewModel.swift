
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
    // Update data in start and when we tap restart button
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

    // we find any object (penguin or None) in every direction ang get result x coordinate and y coordinate
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
    //reproduction animal
    private  func reproduction(animal : Animals){
            let findPlace = findTheObject(animal: animal, title : "None")
            if findPlace.0 {
                if animal.title == "Shark"{
                    animals[10 * findPlace.1 + findPlace.2] = Shark(direction: .None, photo: #imageLiteral(resourceName: "shark"), life: 0, position: Position(x: findPlace.2, y: findPlace.2), title: "Shark", maxLife: 8, isFull: false, stepToEat: 3)
                }
                else if animal.title == "Penguins"{
                    animals[10 * findPlace.1 + findPlace.2] = Penguins(direction: .None, photo: #imageLiteral(resourceName: "penguin"), life: 3, position: Position(x: findPlace.2, y: findPlace.2), title: "Penguins", maxLife: 3)
                }
                
        }
    }
    
    
    private func dead(animal : Shark){
         if !(animal.isFull){
            let oldCoor = animal.position.x*10 + animal.position.y
            animals[oldCoor].photo = #imageLiteral(resourceName: "sea")
            animals[oldCoor].title = "None"
            animals[oldCoor].life = 0
            animals[oldCoor].direction = .None
            animals[oldCoor].maxLife = 0
            
         }else {
            animal.isFull = false
        }
    }
    //make step in chosen direction
    private func makeStep(_ animal : Animals){
        if animal.life == animal.maxLife {
            reproduction(animal: animal)
            animal.life = 0
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
                animals[10 * newX + newY] = Shark(direction: .None, photo: animal.photo, life: animal.life + 1, position: Position(x : newX, y: newY), title: animal.title, maxLife: 8, isFull: (animal as! Shark).isFull, stepToEat: (animal as! Shark).stepToEat)
            }else
                if animal.title == "Penguins"{
                 animals[10 * newX + newY] = Penguins(direction: .None, photo: animal.photo, life: animal.life + 1, position: Position(x : newX, y: newY), title: animal.title, maxLife: 3)
            }
            let oldCoor = 10 * oldX + oldY
            animals[oldCoor].title = "None"
            animals[oldCoor].photo = #imageLiteral(resourceName: "sea")
            animals[oldCoor].life = 0
            animals[oldCoor].direction = .None
            animals[oldCoor].maxLife = 0
        }
        else {
            animal.life += 1
        }
    }
    
   private  func eat(animal : Animals){
            let check = self.findTheObject(animal: animal, title: "Penguins")
            if check.0 {
                self.animals[check.1 * 10 + check.2] = Shark(
                    direction: .None,
                    photo: animal.photo,
                    life: animal.life + 1,
                    position: Position(x: check.1, y: check.2),
                    title: animal.title,
                    maxLife: 8,
                    isFull: true,
                    stepToEat: 3)
                
                let oldCoor = animal.position.x*10 + animal.position.y
                
                self.animals[oldCoor].title = "None"
                self.animals[oldCoor].photo = #imageLiteral(resourceName: "sea")
                self.animals[oldCoor].life = 0
                self.animals[oldCoor].direction = .None
                self.animals[oldCoor].maxLife = 0
            }
            else {
                self.makeStep(animal)
            }
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
    
    private func move (){
        for animal in animals {
            if animal.title != "None"{
                if animal.title == "Shark"{
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.5, execute: {
                        self.eat(animal: animal)
                    })
                    
                }else {
                    makeStep(animal)
                }
            }
        }
    }
    func runStep(){
        cellsArray.removeAll()
        move()
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
