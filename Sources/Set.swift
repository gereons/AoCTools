//
//  Set.swift
//  
//  Advent of Code Tools
//

extension Set {
    public static func + (lhs: Set, rhs: Set) -> Set {
        lhs.union(rhs)
    }

    public static func += (lhs: inout Set, rhs: Set) {
        lhs = lhs.union(rhs)
    }

    public static func + (lhs: Set, rhs: Set.Element) -> Set {
        lhs.union([rhs])
    }

    public static func += (lhs: inout Set, rhs: Set.Element) {
        lhs = lhs.union([rhs])
    }

    public static func - (lhs: Set, rhs: Set) -> Set {
        lhs.subtracting(rhs)
    }

    public static func - (lhs: Set, rhs: Set.Element) -> Set {
        lhs.subtracting([rhs])
    }
}

extension Set {
    public func combinations() -> [Set<Element>] {
        var allCombinations = [Set<Element>]()
        for element in self {
            let oneElementCombo = Set([element])
            for i in 0..<allCombinations.count {
                allCombinations.append(allCombinations[i] + oneElementCombo)
            }
            allCombinations.append(oneElementCombo)
        }
        return allCombinations
    }
}
