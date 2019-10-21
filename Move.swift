import Foundation

class Move {
    var attack: DarwinBoolean
    var defence: DarwinBoolean
    var status: DarwinBoolean
    var name: String
    var type: String
    var mod: Double
    
    init(){
        attack=false
        defence=false
        status=false
        name="BLANK"
        type="none"
        mod=0.0
    }
    init(attackin: DarwinBoolean, defencein: DarwinBoolean, statusin: DarwinBoolean, namein: String, typein: String, modin: Double) {
        attack=attackin
        defence=defencein
        status=statusin
        name=namein
        type=typein
        mod=modin
    }

    func getType() -> String{
        return type
    }

    func getName() -> String{
        return name
    }

    func getAttack() -> DarwinBoolean{
        return attack
    }

    func getStatus() -> DarwinBoolean{
        return status
    }

    func getDefence() -> DarwinBoolean{
        return defence
    }

    func getMod() -> Double{
        return mod
    }
}

class Punch: Move{
    override init(){
        super.init(attackin: true, defencein: false, statusin: false, namein: "Punch", typein: "physical", modin:1.0)
    }   
}

class ArmBlock: Move{
    override init(){
        super.init(attackin: false, defencein: true, statusin: false, namein: "Arm Block", typein: "physical", modin:1.5)
    }   
}

class SpinKick: Move{
    override init(){
        super.init(attackin: true, defencein: false, statusin: false, namein: "Spin Kick", typein: "physical", modin: 1.3)
    }
}

class Intimidate: Move{
    override init(){
        super.init(attackin: false, defencein: false, statusin: true, namein: "Intimidate", typein: "status", modin: 0.7)
    }
}

class RapierSwipe: Move{
    override init(){
        super.init(attackin: true, defencein: false, statusin: false, namein: "Rapier Swipe", typein: "physical", modin: 1.4)
    }
}

class RapierBlock: Move{
    override init(){
        super.init(attackin: false, defencein: true, statusin: false, namein: "Rapier Block", typein: "physical", modin: 2.0)
    }
}

class RapierSpinSlash: Move{
    override init(){
        super.init(attackin: true, defencein: false, statusin: false, namein: "Rapier Spin Slash", typein: "physical", modin: 1.6)
    }
}