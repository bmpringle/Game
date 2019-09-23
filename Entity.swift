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

    func moves_string() -> String{
        return "\(move1.getName())\n\(move2.getName())\n\(move3.getName())\n\(move4.getName())"
    }
    func writeData(relativeFilePath: String){
        var datatowrite = "\(level)\n\(maxHealth)\n\(offence)\n\(defence)\n\(exp)\n"
        datatowrite += "\(move1.getName())\n\(move2.getName())\n\(move3.getName())\n\(move4.getName())\n"
        writeFile(path: relativeFilePath, towrite: NSString(string: datatowrite))
    }

    func intimidated(mod: Double) {
        offenceStatus=mod
    }

    func getsNewMove() {
        switch(level) {
            case 2:
            print("You learned Spin Kick!")
            move3 = SpinKick()
            break
            case 3:
            print("You learned Intimidate!")
            move4 = Intimidate()
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

    func attack(move: Move) -> Int{
        return 0
    }

    func takedamage(damage: Int){
        
    }

    func block(move: Move) {

    }
}