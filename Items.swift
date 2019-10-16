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

    func performUse() {

    }
}

class HealingPotion: Item {
    
    var heal: Int 

    init(itemname: String, healamount: Int) {
        heal=healamount
        super.init(itemname: itemname) 
        type = ItemType.heal      
    }

    override func performUse() {
        
    }
}

func ItemNumInList(name: String, list: [Item]) -> Int{
    for i in 0..<list.count {
        if(String(i).lowercased() == list[i].name.lowercased()) {
            return i
        }
    }
    return -1
}