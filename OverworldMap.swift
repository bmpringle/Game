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

    func room1() {

    }

    func roomEnd() {

    }
}
