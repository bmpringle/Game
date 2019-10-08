class Map {
    var room: Int;
    var backup: Int
    var shouldmoveup: Bool = false
    var shouldmovedown: Bool = false
    var play: Bool = true
    var ThePlayer: Player
    var unsavedPlayer: Player 
    var finished = false

    init(player: Player) {
        room=1
        backup=room
        ThePlayer=player
        unsavedPlayer = player
    }

    enum GameTickEnum {
        case ractions
        case stats
        case quit
    }

    func updatePlayer(player: Player) {
        ThePlayer=player
    }

    func startMap() -> Bool{
        playAmbientMusic()
        while(play && !finished) {
            runRoom()
        }
        stopAmbientMusic()
        return play
    }

    func runRoom() {
        
    }

    func returnPlayer() -> Player {
        return ThePlayer
    }
}