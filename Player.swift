import Foundation

class Player: Entity {

    override init() {
        super.init()
    }

    func printPlayerStats() {
        print("You are level \(level)")
        print("Max health is \(maxHealth)")
        print("Current health is \(health)")
        print("Offence is \(offence)")
        print("Defence is \(defence)")
        print("You have \(exp) xp, and you need \(xpToLevelUp) xp to level up")
        print("Your moves are:\n\(move1.getName())\n\(move2.getName())\n\(move3.getName())\n\(move4.getName())")
    }

    func writeData(){
        var datatowrite = "\(level)\n\(maxHealth)\n\(offence)\n\(defence)\n\(exp)\n"
        datatowrite += "\(move1.getName())\n\(move2.getName())\n\(move3.getName())\n\(move4.getName())\n"
        writeFile(path: "Data/playerdata.data", towrite: NSString(string: datatowrite))
    }

    func readData(){
        let playerdata = readFile(path: "Data/playerdata.data")
        let lines = playerdata.split { $0.isNewline }
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

    override func attack(move: Move, enemy: Entity) -> Int {
        moveOffence=Int(Double(offence)*move.getMod()*offenceStatus)
        let crit = Int.random(in: 0 ... 1)
        if crit == 1 {
            let damage = (moveOffence*3)/2
            print("You get a critical hit!")
            print("You use \(move.getName()) and do \(damage) damage to the \(enemy.getName()).")
            return damage
        }else{
            print("You use \(move.getName()) and do \(moveOffence) damage to the \(enemy.getName()).")
            return moveOffence
        }
    }

    func levelUp() {
        print("You Leveled Up!")
        offence=offence+1
        defence=defence+1
        maxHealth=maxHealth+5
        exp=0
        if(Float(level)/2.0==Float(level/2)){
            offence=offence+2
        }else if(Float(level)/3.0==Float(level/3)){
            defence=defence+1
        }else{
            maxHealth=maxHealth+5
        }
        level=level+1
        xpToLevelUp = level*level  
        health=maxHealth   
        getsNewMove()  
    }

    override func block(move: Move) {
        moveDefence=Int(Double(defence)*move.getMod())
        print("You use \(move.getName())")
    }

    override func takedamage(damage: Int) {
        if(health>=damage){
            if((damage>moveDefence/2)){
                let takendamage = (damage)-moveDefence/2
                print("You take \(takendamage) damage. You have \(health-takendamage) heath left.")
                health=health-takendamage
            }
        }else{
            health=0
        }
        if(health==0){
            isAlive=false
        }
    }
}

