//
//  AStar.swift
//
//  Advent of Code Tools
//
//  based on
//  https://www.raywenderlich.com/1734-how-to-implement-a-pathfinding-with-swift
//  and
//  https://github.com/davecom/SwiftPriorityQueue/blob/master/SwiftPriorityQueue/astar.swift
//

import Collections

public protocol Pathfinding {
    associatedtype Coordinate: Hashable = Point
    associatedtype Cost: Numeric & Comparable = Int

    /// Returns the eligible neighbors of `point`
    /// - Parameter for: the current coordinate
    /// - Returns: the eligible neighbors
    func neighbors(of point: Coordinate) -> [Coordinate]

    /// Return the "cost" to move from `from` to `to`
    /// - Parameters:
    ///   - from: The coordinate to move from
    ///   - to: The coordinate to move to
    /// - Returns: The cost of the move
    func costToMove(from: Coordinate, to: Coordinate) -> Cost

    /// Return the distance between `from` and `to`.
    /// - Parameters:
    ///   - from: The coordinate to move from
    ///   - to: The coordinate to move to
    /// - Returns: The distance between the coordinates
    func distance(from: Coordinate, to: Coordinate) -> Cost

    /// Check if we've reached our destination, only implement this if comparing
    /// coordinates using == does not work
    func goalReached(at: Coordinate, goal: Coordinate) -> Bool
}

// default implementation for simple maps:
// costToMove is 1, distance is manhattan distance
public extension Pathfinding where Coordinate == Point, Cost == Int {
    func costToMove(from: Point, to: Point) -> Int {
        1
    }

    func distance(from: Point, to: Point) -> Int {
        from.distance(to: to)
    }
}

public extension Pathfinding where Coordinate: Equatable {
    func goalReached(at coordinate: Coordinate, goal: Coordinate) -> Bool {
        coordinate == goal
    }
}

// MARK: - implementation

public final class AStarPathfinder<Map: Pathfinding> {
    public typealias Coordinate = Map.Coordinate
    public typealias Cost = Map.Cost

    private final class PathNode: Comparable, CustomDebugStringConvertible {
        let coordinate: Coordinate
        let parent: PathNode?

        var fScore: Cost { gScore + hScore }
        let gScore: Cost
        let hScore: Cost

        init(coordinate: Coordinate, parent: PathNode? = nil, moveCost: Cost = 0, hScore: Cost = 0) {
            self.coordinate = coordinate
            self.parent = parent
            self.gScore = (parent?.gScore ?? 0) + moveCost
            self.hScore = hScore
        }

        static func == (lhs: PathNode, rhs: PathNode) -> Bool {
            lhs.coordinate == rhs.coordinate
        }

        static func < (lhs: PathNode, rhs: PathNode) -> Bool {
            lhs.fScore < rhs.fScore
        }

        var debugDescription: String {
            "pos=\(coordinate) g=\(gScore) h=\(hScore) f=\(fScore)"
        }
    }

    private let map: Map

    public init(map: Map) {
        self.map = map
    }

    public func shortestPath(from start: Coordinate, to destination: Coordinate) -> [Coordinate] {
        var frontier = Heap<PathNode>()
        frontier.insert(PathNode(coordinate: start))

        var explored = [Coordinate: Cost]()
        explored[start] = 0

        while let currentNode = frontier.popMin() {
            let currentCoordinate = currentNode.coordinate

            if map.goalReached(at: currentCoordinate, goal: destination) {
                var result = [Coordinate]()
                var node: PathNode? = currentNode
                while let n = node {
                    result.append(n.coordinate)
                    node = n.parent
                }
                return Array(result.reversed().dropFirst())
            }

            for neighbor in map.neighbors(of: currentCoordinate) {
                let moveCost = map.costToMove(from: currentCoordinate, to: neighbor)
                let newcost = currentNode.gScore + moveCost

                if explored[neighbor] == nil || explored[neighbor]! > newcost {
                    explored[neighbor] = newcost
                    let hScore = map.distance(from: currentCoordinate, to: neighbor)
                    let node = PathNode(coordinate: neighbor, parent: currentNode, moveCost: moveCost, hScore: hScore)
                    frontier.insert(node)
                }
            }
        }

        return []
    }
}
