enum ItemType {
    case heal
    case weapon
    case armor
    case keyitem
    case other
}

class Item {

    var name: String
    var type = ItemType.other
    var uses = 1

    init(itemname: String) {
        name=itemname
    }

    init(itemname: String, usenum: Int) {
        name=itemname
        uses=usenum
    }

    func performUse(entity: Entity) {
        
    }
}

enum WeaponType {
    case sword
    case unarmed
}

class Weapon: Item {

    var move1 = Move()
    var move2 = Move()
    var move3 = Move()
    var move4 = Move()
    var movesusable = 2

    var weaponType = WeaponType.unarmed

    init(itemname: String, weapontype: WeaponType, m1: Move, m2: Move, m3: Move, m4: Move) {
        super.init(itemname: itemname) 
        type = ItemType.weapon  
        weaponType = weapontype 
        move1=m1
        move2=m2
        move3=m3
        move4=m4 
    }

    override func performUse(entity: Entity) {
        entity.equipWeapon(weapon: self, comingfrominv: true)
    }
}

class Unarmed: Weapon {
    init() {
        super.init(itemname: "Unarmed", weapontype: WeaponType.unarmed, m1: Punch(), m2: ArmBlock(), m3: SpinKick(), m4: Intimidate()) 
    }
}

class Rapier: Weapon {
    init() {
        super.init(itemname: "Rapier", weapontype: WeaponType.sword, m1: RapierSwipe(), m2: RapierBlock(), m3: RapierSpinSlash(), m4: Intimidate()) 
    }
}

class HealingPotion: Item {
    
    var heal: Int 

    init(itemname: String, healamount: Int) {
        heal=healamount
        super.init(itemname: itemname) 
        type = ItemType.heal      
    }

    override func performUse(entity: Entity) {
        let currenthealth = entity.getHealth()
        let maxhealth = entity.getMaxHealth()
        if(currenthealth+heal<maxhealth) {
            entity.setHealth(newhealth: currenthealth+heal)
        }else{
            entity.setHealth(newhealth: maxhealth)
        }
    }
}

func ItemNumInList(name: String, list: [Item]) -> Int{
    for i in 0..<list.count {
        if(name.lowercased() == list[i].name.lowercased()) {
            return i
        }
    }
    return -1
}

func match_string_and_att_to_weapon(str: String, movenumunlocked: Int) -> Weapon {
    switch(str) {
        case "Unarmed":
            let weapon = Unarmed()
            weapon.movesusable = movenumunlocked
            return weapon
        case "Rapier":
            let weapon = Rapier()
            weapon.movesusable = movenumunlocked
            return weapon
        default:
            let weapon = Weapon(itemname: "!@#$%^%&^$^#", weapontype: WeaponType.unarmed, m1: Move(), m2: Move(), m3: Move(), m4: Move())
            weapon.movesusable = movenumunlocked
            return weapon
    }
}
