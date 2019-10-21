import Foundation

class Entity {
    var maxHealth = 20
    var health: Int
    var offence = 10
    var defence = 5
    var moveDefence: Int
    var moveOffence: Int
    var exp = 0
    var level = 1;
    var isAlive = true
    var xpToLevelUp: Int
    var move1: Move = Punch()
    var move2: Move = ArmBlock()
    var move3: Move = Move()
    var move4: Move = Move()
    var moveamnt = 2
    var offenceStatus: Double = 1.0
    var name = "entity"
    var items = [Item]()
    var weaponequipped: Weapon = Unarmed()

    func equipWeapon(weapon: Weapon, comingfrominv: Bool) {
        if(comingfrominv) {
            print("??")
            let itemnum = ItemNumInList(name: weapon.name, list: items)
            items.remove(at: itemnum)
        }
        items.append(weaponequipped)
        weaponequipped = weapon
        move1 = weaponequipped.move1
        move2 = weaponequipped.move2

        if(self is Player) {
            print("You equipped the \(weapon.name)!")
        }
    }

    func addItem(item: Item) {
        items.append(item)
    }

    func setHealth(newhealth: Int) {
        health=newhealth
    }

    func getName() -> String {
        return name
    }
    
    func getHealth() -> Int {
        return health
    }

    func getMaxHealth() -> Int {
        return maxHealth
    }

    func useItem(name: String) {
        let itemnum = ItemNumInList(name: name, list: items)
        if(itemnum == -1) {
            if(self is Player) {
                print("You don't have this item!")
            }      
        }else{
            let item = items[itemnum]
            if(item.uses==1) {
                item.performUse(entity: self)
                if(item is Weapon) {

                }else{
                    items.remove(at: itemnum)
                }
            }else{
                item.performUse(entity: self)
                item.uses = item.uses-1
            }
        }
    }

    func heal() {
        health=maxHealth
    }

    func moves_string() -> String{
        return "\(move1.getName())\n\(move2.getName())\n\(move3.getName())\n\(move4.getName())"
    }
    func writeData(relativeFilePath: String){
        var datatowrite = "\(level)\n\(maxHealth)\n\(offence)\n\(defence)\n\(exp)\n"
        datatowrite += "\(move1.getName())\n\(move2.getName())\n\(move3.getName())\n\(move4.getName())\n\(weaponequipped.name)\n\(weaponequipped.movesusable)"
        writeFile(path: relativeFilePath, towrite: NSString(string: datatowrite))
    }

    func intimidated(mod: Double) {
        offenceStatus=mod
    }

    func getsNewMove() {
        switch(weaponequipped.movesusable) {
            case 2:
                if(self is Enemy) {
                    move3 = weaponequipped.move3
                }else if(self is Player) {
                    print("You learned \(weaponequipped.move3.name)!")
                    move3 = weaponequipped.move3
                }
                weaponequipped.movesusable=3
            break
            case 3:
                if(self is Enemy) {
                    move4 = weaponequipped.move4
                }else if(self is Player) {
                    print("You learned \(weaponequipped.move4.name)!")
                    move4 = weaponequipped.move4
                }
                weaponequipped.movesusable=4
            break
            default:
            break
        }
    }

    func readData(relativeFilePath: String){
        let data = readFile(path: relativeFilePath)
        let lines = data.split { $0.isNewline }
        level = Int(String(lines[0]))!
        maxHealth = Int(String(lines[1]))!
        health = maxHealth
        offence = Int(String(lines[2]))!
        defence = Int(String(lines[3]))!
        moveOffence = offence
        moveDefence = defence
        exp = Int(String(lines[4]))!
        move1 = match_string_to_move(str: String(lines[5]))
        move2 = match_string_to_move(str: String(lines[6]))
        move3 = match_string_to_move(str: String(lines[7]))
        move4 = match_string_to_move(str: String(lines[8]))
        xpToLevelUp = level*level
    }

    func match_string_to_move(str: String) -> Move{
        switch(str.lowercased()){
            case Punch().getName().lowercased():
            return Punch()

            case ArmBlock().getName().lowercased():
            return ArmBlock()

            case SpinKick().getName().lowercased():
            return SpinKick()

            case Intimidate().getName().lowercased():
            return Intimidate()

            case RapierSwipe().getName().lowercased():
            return RapierSwipe()

            case RapierBlock().getName().lowercased():
            return RapierBlock()

            case RapierSpinSlash().getName().lowercased():
            return RapierSpinSlash()

            default:
            return Move()
        }
    }

    func getXP() -> Int{
        return exp
    }

    func getXPToLevelUp() -> Int {
        return xpToLevelUp
    }

    func setXP(xpIn: Int) {
        exp=xpIn
    }
    init() {
        health = maxHealth
        xpToLevelUp=1
        moveDefence=defence
        moveOffence=offence

        if(level>1) {
            moveamnt=3
        }

        if(level>2){
            moveamnt=4
        }
    }

    func reset(){
        isAlive = true
        health = maxHealth
        moveOffence=offence
        moveDefence=defence
        offenceStatus=1.0
    }

    func reset(shouldHeal: Bool){
        if(shouldHeal) {
            health = maxHealth
        }
        isAlive = true      
        moveOffence=offence
        moveDefence=defence
        offenceStatus=1.0
    }

    init(healthIn: Int, offenceIn: Int, defenceIn: Int) {
        maxHealth=healthIn
        health=healthIn
        offence=offenceIn
        defence=defenceIn
        xpToLevelUp = level*level
        moveOffence=offence
        moveDefence=defence
    }

    func alive() -> Bool {
        return isAlive
    }

    func resetTurn() {
        moveDefence = defence
    }

    func attack(move: Move, enemy: Entity) -> Int{
        return 0
    }

    func takedamage(damage: Int){
        
    }

    func block(move: Move) {

    }
}