import Foundation
import AVFoundation

func inputForced() -> String? {
    return readLine()
}

func string_unwrapper(str: String?) -> String{
        if let ustr=str {
            return ustr
        }else {
            return "nil"
        }
}

func writeFile(path: String, towrite: NSString) {
    do {
        try  towrite.write(toFile: path, atomically:false, encoding: String.Encoding.utf8.rawValue)
    }
    catch let error as NSError {
        print("ERROR ERROR ABOOOOOOOORT!!!!!!!: \(error).")
    }
}

func readFile(path: String) -> String{
    do {
        // Get the contents
        let contents = try NSString(contentsOfFile: path, encoding: String.Encoding.utf8.rawValue) 
        return contents as String
    }
    catch let error as NSError {
        print("ERROR ERROR ABOOOOOOOORT!!!!!!!: \(error).")
        return "nil"
    }
}

var AmbientMusic: AVAudioPlayer?
var NormalBattleMusic: AVAudioPlayer?

func playAmbientMusic() {
    let path = Bundle.main.path(forResource: "ambient", ofType:"wav")!
    let url = URL(fileURLWithPath: path)

    do {
        AmbientMusic = try AVAudioPlayer(contentsOf: url)
        AmbientMusic?.numberOfLoops = -1
        AmbientMusic?.play()
    } catch {
        print("Couldn't Load Ambient Music")
        // couldn't load file :(
    }
}

func stopAmbientMusic() {
    AmbientMusic?.stop()
}

func playNormalBattleMusic() {
    let path = Bundle.main.path(forResource: "normalbattle", ofType:"wav")!
    let url = URL(fileURLWithPath: path)

    do {
        NormalBattleMusic = try AVAudioPlayer(contentsOf: url)
        NormalBattleMusic?.numberOfLoops = -1
        NormalBattleMusic?.play()
    } catch {
        print("Couldn't Load Normal Battle Music")
        // couldn't load file :(
    }
}

func stopNormalBattleMusic() {
    NormalBattleMusic?.stop()
}