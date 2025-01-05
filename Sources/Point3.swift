//
//  Point3.swift
//
//  Advent of Code Tools
//

/// A point in a 3d coordinate system.
public struct Point3: Hashable, Sendable {
    public let x, y, z: Int

    public static let zero = Point3(0, 0, 0)

    @inlinable
    public init(_ x: Int, _ y: Int, _ z: Int) {
        self.x = x
        self.y = y
        self.z = z
    }

    @inlinable
    public static func + (_ lhs: Point3, _ rhs: Point3) -> Point3 {
        Point3(
            lhs.x + rhs.x,
            lhs.y + rhs.y,
            lhs.z + rhs.z
        )
    }

    @inlinable
    public static func += (_ lhs: inout Point3, _ rhs: Point3) {
        lhs = lhs + rhs
    }

    @inlinable
    public static func - (_ lhs: Point3, _ rhs: Point3) -> Point3 {
        Point3(
            lhs.x - rhs.x,
            lhs.y - rhs.y,
            lhs.z - rhs.z
        )
    }

    @inlinable
    public static func -= (_ lhs: inout Point3, _ rhs: Point3) {
        lhs = lhs - rhs
    }

    @inlinable
    public static func * (_ lhs: Point3, _ rhs: Int) -> Point3 {
        Point3(
            lhs.x * rhs,
            lhs.y * rhs,
            lhs.z * rhs
        )
    }

    // manhattan distance
    @inlinable
    public func distance(to point: Point3 = .zero) -> Int {
        abs(x - point.x) + abs(y - point.y) + abs(z - point.z)
    }

    // aka chess distance
    @inlinable
    public func chebyshevDistance(to point: Point3 = .zero) -> Int {
        max(abs(x - point.x), abs(y - point.y), abs(z - point.z))
    }
}

// MARK: - rotation
extension Point3 {
    public func rotateX(_ degrees: Int) -> Point3 {
        /*
         |1     0           0| |x|   |        x        |   |x'|
         |0   cos θ    −sin θ| |y| = |y cos θ − z sin θ| = |y'|
         |0   sin θ     cos θ| |z|   |y sin θ + z cos θ|   |z'|
         */
        let xNew = x
        let yNew = y * cos(degrees) - z * sin(degrees)
        let zNew = y * sin(degrees) + z * cos(degrees)
        return Point3(xNew, yNew, zNew)
    }

    public func rotateY(_ degrees: Int) -> Point3 {
        /*
         | cos θ    0   sin θ| |x|   | x cos θ + z sin θ|   |x'|
         |   0      1       0| |y| = |         y        | = |y'|
         |−sin θ    0   cos θ| |z|   |−x sin θ + z cos θ|   |z'|
         */
        let xNew = x * cos(degrees) + z * sin(degrees)
        let yNew = y
        let zNew = -x * sin(degrees) + z * cos(degrees)
        return Point3(xNew, yNew, zNew)
    }

    public func rotateZ(_ degrees: Int) -> Point3 {
        /*
         |cos θ   −sin θ   0| |x|   |x cos θ − y sin θ|   |x'|
         |sin θ    cos θ   0| |y| = |x sin θ + y cos θ| = |y'|
         |  0       0      1| |z|   |        z        |   |z'|
         */
        let xNew = x * cos(degrees) - y * sin(degrees)
        let yNew = x * sin(degrees) + y * cos(degrees)
        let zNew = z
        return Point3(xNew, yNew, zNew)
    }

    private func sin(_ degrees: Int) -> Int {
        switch degrees {
        case 0: return 0
        case 90: return 1
        case 180: return 0
        case 270: return -1
        default: fatalError("invalid angle \(degrees)")
        }
    }

    private func cos(_ degrees: Int) -> Int {
        switch degrees {
        case 0: return 1
        case 90: return 0
        case 180: return -1
        case 270: return 0
        default: fatalError("invalid angle \(degrees)")
        }
    }
}

// MARK: - neighbors
extension Point3 {
    public enum Adjacency: Sendable {
        case cardinal
        case ordinal
        case all

        public static let orthogonal = Adjacency.cardinal
        public static let diagonal = Adjacency.ordinal
    }

    // swiftlint:disable comma
    private static let cardinalOffsets = [
        Point3( 1,  0,  0),
        Point3(-1,  0,  0),
        Point3( 0,  1,  0),
        Point3( 0, -1,  0),
        Point3( 0,  0,  1),
        Point3( 0,  0, -1)
    ]

    private static let ordinalOffsets = [
        Point3( 1,  0,  1),
        Point3( 1,  0, -1),
        Point3( 1,  1,  0),
        Point3( 1,  1,  1),
        Point3( 1,  1, -1),
        Point3( 1, -1,  0),
        Point3( 1, -1,  1),
        Point3( 1, -1, -1),

        Point3(-1,  0,  1),
        Point3(-1,  0, -1),
        Point3(-1,  1,  0),
        Point3(-1,  1,  1),
        Point3(-1,  1, -1),
        Point3(-1, -1,  0),
        Point3(-1, -1,  1),
        Point3(-1, -1, -1),

        Point3( 0,  1,  1),
        Point3( 0,  1, -1),
        Point3( 0, -1,  1),
        Point3( 0, -1, -1)
    ]
    // swiftlint:enable comma

    private static let allOffsets = Self.cardinalOffsets + Self.ordinalOffsets

    public func neighbors(adjacency: Adjacency = .cardinal) -> [Point3] {
        let offsets: [Point3]
        switch adjacency {
        case .cardinal: offsets = Self.cardinalOffsets
        case .ordinal: offsets = Self.ordinalOffsets
        case .all: offsets = Self.allOffsets
        }

        return offsets.map { self + $0 }
    }
}

extension Point3: CustomStringConvertible {
    public var description: String {
        "\(x),\(y),\(z)"
    }
}
