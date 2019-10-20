struct Place {
    var room: Int
    var canvisit: Bool
    var name: String
}


class OverworldMap: Map {

    //Room IDs
    var a_hydesville = Place(room: 0, canvisit: false, name: "Ancient Hydesville")

    var visitlist = [Place]()

    override init(player: Player) {
        super.init(player: player)
        room=a_hydesville.room
        visitlist.append(a_hydesville)
    }

    override func runRoom() {

        switch(room) {
            case 0:
                ancient_hydesville()
            break
            default:
                roomEnd()
            break;
        }
    }

    var enter1 = true
    //Transition From Prev. Map
    func ancient_hydesville() {
        if(enter1) {
            print("As you climb out of the hole, you wonder where you are. You look around and do \nnot see the mine you were in, nor do you see any part of Onladro. This place seems\n different, somehow. Older, despite the fact that you've not yet seen any cities, it feels old.")
            print("As you continue to walk, you hear the sounds of a city over the hill.\nYou race up it, hoping to find out where you are, but when you get to the top...")
            print("The city looks like someone recreated ancient Rome, or Greece, but somehow different. Most things seem primitve\nbut there are things there that make no sense, floating buildings,\nstrange blue orbs surrounded by shields that float in the air, the list goes on and on.\nYou look at yourself and realize, that without even noticing, your clothes were changed to what people\nhere dress like.")
            print("______________________________________")
            print("   You discovered ANCIENT HYDESVILLE")
            print("______________________________________")
            visitlist[a_hydesville.room].canvisit = true
            enter1=false
        }else{
            print("As you walk through the street, you see an shop, a strange tower, and a town square. Where do you go?")
            if(game_tick()==GameTickEnum.ractions) {
                print("Options:")
                print("1. Fast Travel")
                print("2. Enter the Shop")
                print("3. Go to the Tower")
                print("4. Enter the Town Square")
                let action = checkactions()
                if(action==0) {
                    changePlace()
                }else if(action==1) {
                    let shop = ShopMap(money: ThePlayer.getMoney())
                    shop.addItemToShop(item: HealingPotion(itemname: "Healing Potion", healamount: 10), price: 20)
                    shop.addItemToShop(item: Rapier(), price: 55)
                    let shopdata = shop.runshop()
                    ThePlayer.setMoney(newmoney: shopdata.money)

                    if(shopdata.itemShop.item.name=="nil") {

                    }else{
                        ThePlayer.addItem(item: shopdata.itemShop.item)
                    }
                }else if(action==2) {
                    
                }else if(action==3) {
                    
                }
            }
        }
    }

    func checkactions() -> Int {
        let input = string_unwrapper(str:inputForced())
        if(input.lowercased() == "fast travel" || input.lowercased() == "1") {
            return 0
        } else if(input.lowercased() == "enter the shop" || input.lowercased() == "2") {
            return 1
        }else if(input.lowercased() == "go to the tower" || input.lowercased() == "3") {
            return 2
        }else if(input.lowercased() == "enter the town square" || input.lowercased() == "4") {
            return 3
        }
        return -1
    }
    
    func changePlace(){
        print("Places you can visit:")
        for i in 0..<visitlist.count {
            if(visitlist[i].canvisit) {
                let roomnum = String(visitlist[i].room+1)
                print(" " + roomnum + ". " + visitlist[i].name)
            }
        }

        let input = string_unwrapper(str:inputForced())
        for i in 0..<visitlist.count {
            let roomnum = String(visitlist[i].room+1)
            if(input.lowercased() == visitlist[i].name.lowercased() || input.lowercased() == roomnum) {
                print("Travelling to \(visitlist[i].name)")
                room = visitlist[i].room
                break
            }
        }
    }

    func roomEnd() {
        shouldmoveup=false
        finished=true
    }

    func game_over() {
        //Room 1(Hydesville)
        enter1=true
    }
}

