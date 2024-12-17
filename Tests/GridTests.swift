//
//  GridTests.swift
//  
//  Advent of Code tools
//

import Testing
import AoCTools

@Suite
struct GridTests {
    @Test func testParseBool() throws {
        let input = """
            ###
            #.#
            ###
            """
        let grid = Grid<Bool>.parse(input)

        #expect(grid.points.count { !$0.value } == 1)
        #expect(grid.points.count { $0.value } == 8)
        #expect(grid.minX == 0)
        #expect(grid.maxX == 2)
        #expect(grid.minY == 0)
        #expect(grid.maxY == 2)

        let s = grid.points.draw(xRange: grid.xRange, yRange: grid.yRange)
        #expect(s.joined(separator: "\n") == input)
    }

    @Test func testParseCustom() throws {
        enum Tile: Character, Drawable {
            case wall = "#"
            case floor = "."
            case door = ":"
        }

        let input = """
            ###
            :.:
            ###
            """
        let grid = Grid<Tile>.parse(input)

        #expect(grid.points.count { $0.value == .floor } == 1)
        #expect(grid.points.count { $0.value == .wall } == 6)
        #expect(grid.points.count { $0.value == .door } == 2)
        #expect(grid.minX == 0)
        #expect(grid.maxX == 2)
        #expect(grid.minY == 0)
        #expect(grid.maxY == 2)

        let s = grid.points.draw(xRange: grid.xRange, yRange: grid.yRange)
        #expect(s.joined(separator: "\n") == input)
    }

    @Test func testGridNotAtOrigin() throws {
        let input = """
            ###
            #.#
            ###
            """
        let grid1 = Grid<Bool>.parse(input)

        let offset = Point(5, 5)
        let offsetGrid = Dictionary(uniqueKeysWithValues: grid1.points.map { ($0.key + offset, $0.value) })

        let grid = Grid(points: offsetGrid)
        #expect(grid.minX == 5)
        #expect(grid.maxX == 7)
        #expect(grid.minY == 5)
        #expect(grid.maxY == 7)

        let s = grid.points.draw(xRange: grid.xRange, yRange: grid.yRange)
        #expect(s.joined(separator: "\n") == input)
    }

    @Test func testGridSparse() throws {
        let input = """
            ###
            ...
            ###
            """
        let grid1 = Grid<Bool>.parse(input)
        var points = grid1.points
        points[Point(0, 1)] = nil
        points[Point(1, 1)] = nil
        points[Point(2, 1)] = nil

        let grid = Grid(points: points)

        #expect(grid.points.count { !$0.value } == 0)
        #expect(grid.points.count { $0.value } == 6)
        #expect(grid.minX == 0)
        #expect(grid.maxX == 2)
        #expect(grid.minY == 0)
        #expect(grid.maxY == 2)

        let s = grid.points.draw(xRange: grid.xRange, yRange: grid.yRange)
        #expect(s.joined(separator: "\n") == input)
    }

    @Test func testInitDict() throws {
        let points: [Point: Character] = [Point(0, 0): "O", Point(1, 1): "X"]
        let grid = Grid(points: points)
        #expect(grid.points.count == 2)
        #expect(grid.minX == 0)
        #expect(grid.maxX == 1)
        #expect(grid.minY == 0)
        #expect(grid.maxY == 1)
        let s = grid.points.draw(xRange: grid.xRange, yRange: grid.yRange)
        #expect(s.joined(separator: "\n") == "O.\n.X")
    }

    @Test func testInitPoints() throws {
        let points = [Point(0, 0), Point(1, 1)]
        let grid = Grid(points: points)
        #expect(grid.points.count == 2)
        #expect(grid.minX == 0)
        #expect(grid.maxX == 1)
        #expect(grid.minY == 0)
        #expect(grid.maxY == 1)
        let s = grid.points.draw(xRange: grid.xRange, yRange: grid.yRange)
        #expect(s.joined(separator: "\n") == "#.\n.#")
    }
}
