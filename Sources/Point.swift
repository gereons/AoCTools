//
//  Point.swift
//
//  Advent of Code Tools
//

/// A point in a 2d coordinate system.
public struct Point: Hashable, Sendable {
    public let x, y: Int

    public static let zero = Point(0, 0)

    @inlinable
    public init(_ x: Int, _ y: Int) {
        self.x = x
        self.y = y
    }

    @inlinable
    public static func + (_ lhs: Point, _ rhs: Point) -> Point {
        Point(lhs.x + rhs.x, lhs.y + rhs.y)
    }

    @inlinable
    public static func + (_ lhs: Point, _ rhs: Direction) -> Point {
        Point(lhs.x + rhs.offset.x, lhs.y + rhs.offset.y)
    }

    @inlinable
    public static func += (_ lhs: inout Point, _ rhs: Point) {
        lhs = lhs + rhs
    }

    @inlinable
    public static func - (_ lhs: Point, _ rhs: Point) -> Point {
        Point(lhs.x - rhs.x, lhs.y - rhs.y)
    }

    @inlinable
    public static func -= (_ lhs: inout Point, _ rhs: Point) {
        lhs = lhs - rhs
    }

    @inlinable
    public static func * (_ lhs: Point, _ rhs: Int) -> Point {
        Point(lhs.x * rhs, lhs.y * rhs)
    }

    // manhattan distance
    @inlinable
    public func distance(to point: Point = .zero) -> Int {
        abs(x - point.x) + abs(y - point.y)
    }

    // aka chess distance
    @inlinable
    public func chebyshevDistance(to point: Point = .zero) -> Int {
        max(abs(x - point.x), abs(y - point.y))
    }
}

// MARK: - rotation
extension Point {
    public func rotated(by degrees: Int) -> Point {
        switch degrees {
        case 0, 360: return self
        case 90: return Point(-y, x)
        case 180: return Point(-x, -y)
        case 270: return Point(y, -x)
        default: fatalError("invalid angle \(degrees)")
        }
    }
}

// MARK: - neighbors
extension Point {
    public enum Adjacency: Sendable {
        case cardinal
        case ordinal
        case all

        public static let orthogonal = Adjacency.cardinal
        public static let diagonal = Adjacency.ordinal
    }

    public func neighbors(adjacency: Adjacency = .cardinal) -> [Point] {
        let offsets: [Direction]
        switch adjacency {
        case .cardinal: offsets = Direction.cardinal
        case .ordinal: offsets = Direction.ordinal
        case .all: offsets = Direction.allCases
        }

        return offsets.map { self + $0.offset }
    }

    @inlinable
    public func moved(to direction: Direction, steps: Int = 1) -> Point {
        self + direction.offset * steps
    }

    // return all points between self and `end`. Angle between self and `end` must be a multiple of 45°
    public func line(to end: Point) -> [Point] {
        let dx = (end.x - x).signum()
        let dy = (end.y - y).signum()
        let range = max(abs(x - end.x), abs(y - end.y))
        return (0 ..< range).map { step in
            Point(x + dx * step, y + dy * step)
        }
    }
}

extension Point: CustomStringConvertible {
    public var description: String {
        "\(x),\(y)"
    }
}

extension Point: Comparable {
    /// compare in "reading order" (top to bottom, left to right)
    public static func < (lhs: Point, rhs: Point) -> Bool {
        if lhs.y != rhs.y {
            return lhs.y < rhs.y
        }
        return lhs.x < rhs.x
    }
}
