import Foundation

public extension Array where Element == Int {
    func toString() -> String {
        var intString = self.compactMap { String($0) }.joined(separator: ",")
        intString.insert("{", at: intString.startIndex)
        intString.insert("}", at: intString.endIndex)
        return intString
    }
}
