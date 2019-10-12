class OverworldMap: Map {
    
    

    override init(player: Player) {
        super.init(player: player)
    }

    override func runRoom() {

        if(shouldmoveup==true) {
            room=room+1
        }

        if(shouldmovedown==true) {
            room=room-1
        }

        if(shouldmovedown==true && shouldmoveup==true) {
            backup=room
            room = -1
        }

        switch(room) {
            case 1:
                room1()
            break
            default:
                roomEnd()
            break;
        }
    }

    var enter1 = true
    //Transition From Prev. Map
    func room1() {
        if(enter1) {
            print("As you climb out of the hole, you wonder where you are. You look around and do \nnot see the mine you were in, nor do you see any part of Onladro. This place seems\n different, somehow. Older, despite the fact that you've not yet seen any cities, it feels old.")
            print("As you continue to walk, you hear the sounds of a city over the hill.\nYou race up it, hoping to find out where you are, but when you get to the top...")
            print("The city looks like someone recreated ancient Rome, or Greece, but somehow different. Most things seem primitve\nbut there are things there that make no sense, floating buildings,\nstrange blue orbs surrounded by shields that float in the air, the list goes on and on.\nYou look at yourself and realize, that without even noticing, your clothes were changed to what people\nhere dress like.")
            print("______________________________________")
            print("   You discovered ANCIENT HYDESVILLE")
            print("______________________________________")
            enter1=false
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
