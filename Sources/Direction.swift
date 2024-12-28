//
//  Direction.swift
//  
//  Advent of Code tools
//

// MARK: 2d directions
public enum Turn: CaseIterable, Sendable {
    /// turn clockwise / right
    case clockwise

    /// turn counterclockwise / left
    case counterclockwise

    static let right = Turn.clockwise
    static let left = Turn.counterclockwise
}

public enum Direction: String, CaseIterable, Sendable {
    case n, w, s, e
    case nw, ne, sw, se

    public static let up = Direction.n
    public static let down = Direction.s
    public static let left = Direction.w
    public static let right = Direction.e

    /// the cardinal / orthogonal directions
    public static let cardinal: [Direction] = [ .n, .w, .s, .e ]
    public static let orthogonal = Direction.cardinal

    /// the ordinal / diagonal directions
    public static let ordinal: [Direction] = [ .nw, .ne, .sw, .se ]
    public static let diagonal = Direction.ordinal

    public var offset: Point {
        switch self {
        case .n: Point(0, -1)
        case .w: Point(-1, 0)
        case .s: Point(0, 1)
        case .e: Point(1, 0)
        case .nw: Point(-1, -1)
        case .ne: Point(1, -1)
        case .sw: Point(-1, 1)
        case .se: Point(1, 1)
        }
    }

    public var opposite: Direction {
        switch self {
        case .n: .s
        case .s: .n
        case .w: .e
        case .e: .w
        case .ne: .sw
        case .nw: .se
        case .se: .nw
        case .sw: .ne
        }
    }

    public func turned(_ turn: Turn, by degrees: Int = 90) -> Direction {
        switch (turn, degrees) {
        case (.clockwise, 90):
            switch self {
            case .n: return .e
            case .e: return .s
            case .s: return .w
            case .w: return .n
            case .ne: return .se
            case .nw: return .ne
            case .se: return .sw
            case .sw: return .nw
            }
        case (.clockwise, 45):
            switch self {
            case .n: return .ne
            case .e: return .se
            case .s: return .sw
            case .w: return .nw
            case .ne: return .e
            case .nw: return .n
            case .se: return .s
            case .sw: return .w
            }
        case (.counterclockwise, 90):
            switch self {
            case .n: return .w
            case .e: return .n
            case .s: return .e
            case .w: return .s
            case .ne: return .nw
            case .nw: return .sw
            case .se: return .ne
            case .sw: return .se
            }
        case (.counterclockwise, 45):
            switch self {
            case .n: return .nw
            case .e: return .ne
            case .s: return .se
            case .w: return .sw
            case .ne: return .n
            case .nw: return .w
            case .se: return .e
            case .sw: return .s
            }
        default:
            fatalError("unsupported turn degrees \(degrees)")
        }
    }
}

extension Direction: CustomStringConvertible {
    public var description: String {
        switch self {
        case .n: "^"
        case .w: "<"
        case .s: "v"
        case .e: ">"
        case .nw: "↖︎"
        case .ne: "↗︎"
        case .sw: "↙︎"
        case .se: "↘︎"
        }
    }
}
