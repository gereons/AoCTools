//
//  HexPoint.swift
//
//  Advent of Code Tools
//
//  see https://www.redblobgames.com/grids/hexagons/

public protocol HexDirection {
    var offset: Hex.Point { get }
    var opposite: Self { get }
    func turned(_ turn: Turn) -> Self
}

public enum Hex {
    public enum Orientation {
        case flat
        case pointy
    }

    public struct Point: Hashable, CustomStringConvertible, Sendable {
        public let q, r, s: Int

        @inlinable
        public init(_ q: Int, _ r: Int, _ s: Int) {
            self.q = q
            self.r = r
            self.s = s
        }

        public static let zero = Point(0, 0, 0)

        @inlinable
        public func add(_ point: Point) -> Point {
            Point(q + point.q, r + point.r, s + point.s)
        }

        @inlinable
        public static func + (_ lhs: Point, _ rhs: Point) -> Point {
            lhs.add(rhs)
        }

        @inlinable
        public func distance(to point: Point = .zero) -> Int {
            (abs(q - point.q) + abs(r - point.r) + abs(s - point.s)) / 2
        }

        public var description: String {
            "\(q),\(r),\(s)"
        }

        public func neighbors(orientation: Orientation) -> [Point] {
            switch orientation {
            case .flat:
                return FlatDirection.allCases.map { self + $0.offset }
            case .pointy:
                return PointyDirection.allCases.map { self + $0.offset }
            }
        }

        @inlinable
        public func moved(to direction: PointyDirection) -> Point {
            self + direction.offset
        }

        @inlinable
        public func moved(to direction: FlatDirection) -> Point {
            self + direction.offset
        }
    }

    // "Pointy" directions (the hex has corners pointing up and down)
    public enum PointyDirection: String, CaseIterable, HexDirection {
        case ne, e, se, sw, w, nw

        public var offset: Point {
            switch self {
            case .ne: Point(1, -1, 0)
            case .e: Point(1, 0, -1)
            case .se: Point(0, 1, -1)
            case .sw: Point(-1, 1, 0)
            case .w: Point(-1, 0, 1)
            case .nw: Point(0, -1, 1)
            }
        }

        public var opposite: Self {
            switch self {
            case .w: return .e
            case .e: return .w
            case .ne: return .sw
            case .nw: return .se
            case .se: return .nw
            case .sw: return .ne
            }
        }

        public func turned(_ turn: Turn) -> Self {
            switch turn {
            case .clockwise:
                switch self {
                case .w: return .nw
                case .e: return .se
                case .ne: return .e
                case .nw: return .ne
                case .se: return .sw
                case .sw: return .w
                }
            case .counterclockwise:
                switch self {
                case .w: return .sw
                case .e: return .ne
                case .ne: return .nw
                case .nw: return .w
                case .se: return .e
                case .sw: return .se
                }
            }
        }
    }

    // "Flat" directions (the hex has flat sides pointing up and down)
    public enum FlatDirection: String, CaseIterable, HexDirection {
        case n, nw, sw, s, se, ne

        public var offset: Point {
            switch self {
            case .n: return Point(0, -1, 1)
            case .nw: return Point(-1, 0, 1)
            case .sw: return Point(-1, 1, 0)
            case .s: return Point(0, 1, -1)
            case .se: return Point(1, 0, -1)
            case .ne: return Point(1, -1, 0)
            }
        }

        public var opposite: Self {
            switch self {
            case .n: return .s
            case .s: return .n
            case .ne: return .sw
            case .nw: return .se
            case .se: return .nw
            case .sw: return .ne
            }
        }

        public func turned(_ turn: Turn) -> Self {
            switch turn {
            case .clockwise:
                switch self {
                case .n: return .ne
                case .s: return .sw
                case .ne: return .se
                case .nw: return .n
                case .se: return .s
                case .sw: return .nw
                }
            case .counterclockwise:
                switch self {
                case .n: return .nw
                case .s: return .se
                case .ne: return .n
                case .nw: return .sw
                case .se: return .ne
                case .sw: return .s
                }
            }
        }
    }
}
