//
//  Array+Chunk.swift
//  
//  Advent of Code Tools
//

extension Array {
    /// split an array into chunks so that for each chunk, `condition` is true
    public func chunked(by condition: (Element, Element) -> Bool) -> [[Element]] {
        guard !isEmpty else { return [] }
        var result = [[Element]]()
        var tmp = [Element]()
        for index in 0 ..< self.count - 1 {
            tmp.append(self[index])
            if !condition(self[index], self[index + 1]) {
                result.append(tmp)
                tmp.removeAll()
            }
        }
        tmp.append(self[self.count - 1])
        result.append(tmp)

        return result
    }
}

extension Array {
    /// split an array into groups that are separated at each element where `condition` is true
    public func grouped(by condition: (Element) -> Bool) -> [[Element]] {
        var tmp = [Element]()
        var result = [[Element]]()
        for element in self {
            if condition(element) {
                result.append(tmp)
                tmp.removeAll()
            } else {
                tmp.append(element)
            }
        }
        if !tmp.isEmpty {
            result.append(tmp)
        }
        return result
    }
}
