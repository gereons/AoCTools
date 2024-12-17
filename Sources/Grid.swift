//
//  Grid.swift
//
//  Advent of Code Tools
//

public struct Grid<Value: Drawable> {
    public let points: [Point: Value]
    public let minX: Int
    public let maxX: Int
    public let minY: Int
    public let maxY: Int

    public var xRange: ClosedRange<Int> { minX ... maxX }
    public var yRange: ClosedRange<Int> { minY ... maxY }

    public init(points: [Point]) where Value == Bool {
        let map = Dictionary(points.map { ($0, true) }, uniquingKeysWith: { _, new in new })
        self.init(points: map)
    }

    public init(points: [Point: Value]) {
        let (minX, maxX) = points.keys.minAndMax(of: \.x)!
        let (minY, maxY) = points.keys.minAndMax(of: \.y)!
        self.init(points: points, minX: minX, maxX: maxX, minY: minY, maxY: maxY)
    }

    public init(points: [Point: Value], minX: Int, maxX: Int, minY: Int, maxY: Int) {
        self.points = points
        self.minX = minX
        self.maxX = maxX
        self.minY = minY
        self.maxY = maxY
    }

    public static func parse(_ string: String) -> Grid {
        parse(string.lines)
    }

    public static func parse(_ data: [String]) -> Grid {
        var points = [Point: Value]()

        for (y, line) in data.enumerated() {
            for (x, ch) in line.enumerated() {
                let point = Point(x, y)
                points[point] = Value.value(for: ch)
            }
        }

        return Grid(points: points,
                    minX: 0, maxX: data[0].count - 1,
                    minY: 0, maxY: data.count - 1)
    }

    public func draw() {
        points.draw(xRange: xRange, yRange: yRange).forEach {
            print($0)
        }
    }
}

extension Grid: Equatable where Value: Equatable { }

extension Grid: Hashable where Value: Hashable { }
