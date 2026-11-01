import Foundation

// FROM ARRAY functions

public extension Array where Element == Int {
    func intArrToStr() -> String {
        var intString = self.compactMap { String($0) }.joined(separator: ",")
        intString.insert("{", at: intString.startIndex)
        intString.insert("}", at: intString.endIndex)
        return intString
    }
}

// STRING TO ARRAY functions

public extension String {
    func strToIntArray() -> [Int] {
        var tmpStr = self
        if tmpStr.isEmpty {
            return []
        }
        
        tmpStr.removeFirst()
        tmpStr.removeLast()
        
        let array = tmpStr.components(separatedBy: ",")
        let intArray = array.compactMap { Int($0) }
        
        return intArray
    }
    
    func strToStrArray() -> [String] {
        var tmpStr = self
        if tmpStr.isEmpty {
            return []
        }
        
        tmpStr.removeFirst()
        tmpStr.removeLast()
        
        let array = tmpStr.components(separatedBy: ",")
        let strArray = array.compactMap { String($0) }
        
        return strArray
    }
}
