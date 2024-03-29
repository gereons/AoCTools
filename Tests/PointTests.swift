//
//  PointTests.swift
//  
//  Advent of Code tools
//

import XCTest
import AoCTools

class PointTests: XCTestCase {

    func testPoint() throws {
        let zero = Point.zero
        XCTAssertEqual(zero.x, 0)
        XCTAssertEqual(zero.y, 0)

        let one = Point(1, 1)
        XCTAssertEqual(one.x, 1)
        XCTAssertEqual(one.y, 1)

        let sum = zero + one
        XCTAssertEqual(sum, one)

        let two = one + one
        XCTAssertEqual(two.x, 2)
        XCTAssertEqual(two.y, 2)

        let three = one * 3
        XCTAssertEqual(three.x, 3)
        XCTAssertEqual(three.y, 3)
    }

    func testDistance() throws {
        XCTAssertEqual(Point(0, 5).distance(), 5)
        XCTAssertEqual(Point(5, 0).distance(), 5)

        XCTAssertEqual(Point(1, 5).distance(), 6)
        XCTAssertEqual(Point(5, 1).distance(), 6)

        XCTAssertEqual(Point(0, 5).distance(to: Point(0, 4)), 1)
        XCTAssertEqual(Point(5, 0).distance(to: Point(10, 0)), 5)
    }

    func testNeighbors() throws {
        let zero = Point.zero

        XCTAssertEqual(zero.neighbors(adjacency: .all).count, 8)
        XCTAssertEqual(zero.neighbors(adjacency: .orthogonal).count, 4)
        XCTAssertEqual(zero.neighbors(adjacency: .diagonal).count, 4)

        for n in zero.neighbors(adjacency: .orthogonal) {
            XCTAssertEqual(n.distance(to: .zero), 1)
        }

        for n in zero.neighbors(adjacency: .diagonal) {
            XCTAssertEqual(n.distance(to: .zero), 2)
        }
    }

    func testOppositeDirection() throws {
        let zero = Point.zero

        for direction in Direction.allCases {
            XCTAssertEqual(zero + direction.offset + direction.opposite.offset, zero)
        }

    }

    func testTurns() throws {
        var turned = Set<Direction>()

        for direction in Direction.allCases {
            turned.insert(direction.turned(.clockwise, by: 90))
        }
        XCTAssertEqual(Direction.allCases.count, turned.count)

        turned.removeAll()
        for direction in Direction.allCases {
            turned.insert(direction.turned(.clockwise, by: 45))
        }
        XCTAssertEqual(Direction.allCases.count, turned.count)

        turned.removeAll()
        for direction in Direction.allCases {
            turned.insert(direction.turned(.counterclockwise, by: 90))
        }
        XCTAssertEqual(Direction.allCases.count, turned.count)

        turned.removeAll()
        for direction in Direction.allCases {
            turned.insert(direction.turned(.counterclockwise, by: 45))
        }
        XCTAssertEqual(Direction.allCases.count, turned.count)
    }

    func testMoves() throws {
        XCTAssertEqual(Point.zero.moved(to: .n), Point(0, -1))
        XCTAssertEqual(Point.zero.moved(to: .up), Point(0, -1))

        XCTAssertEqual(Point.zero.moved(to: .s), Point(0, 1))
        XCTAssertEqual(Point.zero.moved(to: .down), Point(0, 1))

        XCTAssertEqual(Point.zero.moved(to: .w), Point(-1, 0))
        XCTAssertEqual(Point.zero.moved(to: .left), Point(-1, 0))

        XCTAssertEqual(Point.zero.moved(to: .e), Point(1, 0))
        XCTAssertEqual(Point.zero.moved(to: .right), Point(1, 0))
    }
}
