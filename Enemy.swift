class Enemy: Entity {

    override init() {
        super.init()
    }

    func printEnemyStats() {
        print("Enemy level is: \(level)")
        print("Max health is \(maxHealth)")
        print("Offence is \(offence)")
        print("Defence is \(defence)")
        print("Enemy moves are:\n\(move1.getName())\n\(move2.getName())\n\(move3.getName())\n\(move4.getName())")
    }

    func getLevel() -> Int{
        return level
    }

    override func attack(move: Move) -> Int {
        moveOffence=Int(Double(offence)*move.getMod()*offenceStatus)
        let crit = Int.random(in: 0 ... 1)
        if crit == 1 {
            let damage = (moveOffence*3)/2
            print("The enemy got a critical hit!")
            print("The enemy used \(move.getName()) and did \(damage) damage to you.")
            return damage
        }else{
            print("The enemy used \(move.getName()) and did \(moveOffence) damage to you.")
            return moveOffence
        }
    }

    func levelUp() {
        offence=offence+1
        defence=defence+1
        maxHealth=maxHealth+5
        health=maxHealth
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
        print("The enemy used \(move.getName())")
    }

    override func takedamage(damage: Int) {
        if(health>=damage){
            if((damage>moveDefence/2)){
                let takendamage = (damage)-moveDefence/2
                print("The enemy took \(takendamage) damage. The enemy has \(health-takendamage) heath left.")
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