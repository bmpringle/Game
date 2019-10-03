import Foundation

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