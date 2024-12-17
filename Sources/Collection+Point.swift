//
//  Collection+Point.swift
//
//  Advent of Code Tools
//

extension Collection {
    public subscript(safe index: Index) -> Element? {
        startIndex..<endIndex ~= index ? self[index] : nil
    }
}

// read access 2D arrays using points as subscripts
extension Collection where Element: Collection, Index == Int, Element.Index == Int {
    public subscript(_ index: Point) -> Element.Element {
        self[index.y][index.x]
    }

    public subscript(safe index: Point) -> Element.Element? {
        self[safe: index.y]?[safe: index.x]
    }
}

// write access 2D arrays using points as subscripts
extension MutableCollection where Element: MutableCollection, Index == Int, Element.Index == Int {
    public subscript(_ index: Point) -> Element.Element {
        get { self[index.y][index.x] }
        set { self[index.y][index.x] = newValue }
    }

    public subscript(safe index: Point) -> Element.Element? {
        get { self[safe: index.y]?[safe: index.x] }
        set {
            guard let newValue else { return }
            if startIndex ..< endIndex ~= index.y {
                if self[index.y].startIndex ..< self[index.y].endIndex ~= index.x {
                    self[index.y][index.x] = newValue
                }
            }
        }
    }
}
