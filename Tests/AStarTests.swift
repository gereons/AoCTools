//
//  AStarTests.swift
//  
//  Advent of Code tools
//

import Testing
import AoCTools

@Suite
struct AStarTests {
    struct Map: Pathfinding {
        let grid: Grid<Bool>
        let adjacency: Point.Adjacency

        init(_ data: [String], adjacency: Point.Adjacency = .cardinal) {
            grid = Grid.parse(data)
            self.adjacency = adjacency
        }

        func draw() {
            grid.draw()
        }

        func neighbors(of point: Point) -> [Point] {
            point
                .neighbors(adjacency: adjacency)
                .filter {
                    $0.x >= 0 && $0.x <= grid.maxX && $0.y >= 0 && $0.y <= grid.maxY
                }
                .filter {
                    grid.points[$0] == false
                }
        }

        func costToMove(from: Point, to: Point) -> Int {
            1
        }

        func distance(from: Point, to: Point) -> Int {
            from.distance(to: to)
        }
    }

    @Test func testPathfinding() throws {
        let map = Map([
            "..........",
            "..........",
            "#########.",
            "..........",
            ".........."
        ])

        let pathfinder = AStarPathfinder(map: map)
        let path = pathfinder.shortestPath(from: .zero, to: Point(9, 4))

        #expect(path.count == 13)
        #expect(!path.contains(.zero))
        #expect(path.contains(Point(9, 4)))
        #expect(path.contains(Point(9, 2)))
    }

    @Test func testPathfindingDiagonal() throws {
        let map = Map([
            "...........",
            "...........",
            "##########.",
            "...........",
            "..........."
        ], adjacency: .ordinal)

        let pathfinder = AStarPathfinder(map: map)
        let path = pathfinder.shortestPath(from: .zero, to: Point(10, 4))

        #expect(path.count == 12)
        #expect(!path.contains(.zero))
        #expect(path.contains(Point(1, 1)))
        #expect(path.contains(Point(2, 0)))
        #expect(path.contains(Point(9, 3)))
        #expect(path.contains(Point(10, 2)))
        #expect(path.contains(Point(10, 4)))

        #expect(!path.contains(Point(1, 0)))
        #expect(!path.contains(Point(0, 1)))
    }

    @Test func testPathfindingSnake() throws {
        let map = Map([
            "..........",
            "#########.",
            "..........",
            ".#########",
            ".........."
        ])

        let pathfinder = AStarPathfinder(map: map)
        let path = pathfinder.shortestPath(from: .zero, to: Point(9, 4))

        #expect(path.count == 31)
        #expect(!path.contains(.zero))
        #expect(path.contains(Point(9, 4)))
        #expect(path.contains(Point(9, 2)))
        #expect(path.contains(Point(0, 3)))
    }

    @Test func testPathfindingBlocked() throws {
        let map = Map([
            "..........",
            "..........",
            "..........",
            "........##",
            "........#."
        ])

        let pathfinder = AStarPathfinder(map: map)
        let path = pathfinder.shortestPath(from: .zero, to: Point(9, 4))

        #expect(path.isEmpty)
    }
}
