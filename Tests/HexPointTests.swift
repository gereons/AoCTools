//
//  HexPointTests.swift
//  
//  Advent of Code tools
//

import Testing
import AoCTools

@Suite
struct HexPointTests {

    @Test func testPoint() throws {
        let zero = Hex.Point.zero
        #expect(zero.q == 0)
        #expect(zero.r == 0)
        #expect(zero.s == 0)

        let one = Hex.Point(1, 1, 1)
        #expect(one.q == 1)
        #expect(one.r == 1)
        #expect(one.s == 1)

        let sum = zero + one
        #expect(sum == one)

        let two = one + one
        #expect(two.q == 2)
        #expect(two.r == 2)
        #expect(two.s == 2)
    }

    @Test func testDistance() throws {
        #expect(Hex.Point.zero.distance(to: .zero) == 0)

        #expect(Hex.Point(1, 1, 0).distance() == 1)
        #expect(Hex.Point(1, 0, 1).distance() == 1)
        #expect(Hex.Point(0, 1, 1).distance() == 1)
    }

    @Test func testNeighbors() throws {
        let start = Hex.Point.zero.moved(to: .n).moved(to: .n).moved(to: .n)
        #expect(start.distance(to: .zero) == 3)

        let pointyMoved = Hex.Point.zero.moved(to: .e).moved(to: .e).moved(to: .e)
        #expect(pointyMoved.distance(to: .zero) == 3)

        #expect(start.neighbors(orientation: .pointy).count == 6)
        #expect(start.neighbors(orientation: .flat).count == 6)

        for n in start.neighbors(orientation: .pointy) {
            #expect(n.distance(to: start) == 1)
        }

        for n in start.neighbors(orientation: .flat) {
            #expect(n.distance(to: start) == 1)
        }
    }

    @Test func testOppositeDirection() throws {
        let zero = Hex.Point.zero

        for direction in Hex.PointyDirection.allCases {
            #expect(zero + direction.offset + direction.opposite.offset == zero)
        }
        for direction in Hex.FlatDirection.allCases {
            #expect(zero + direction.offset + direction.opposite.offset == zero)
        }
    }

    @Test func testTurns() throws {
        #expect(Set(Hex.FlatDirection.allCases.map { $0.turned(.clockwise) }).count == Hex.FlatDirection.allCases.count)
        #expect(Set(Hex.FlatDirection.allCases.map { $0.turned(.counterclockwise) }).count == Hex.FlatDirection.allCases.count)
        #expect(Set(Hex.PointyDirection.allCases.map { $0.turned(.clockwise) }).count == Hex.PointyDirection.allCases.count)
        #expect(Set(Hex.PointyDirection.allCases.map { $0.turned(.counterclockwise) }).count == Hex.PointyDirection.allCases.count)
    }

}
