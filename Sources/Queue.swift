//
//  Queue.swift
//
//  Advent of Code Tools
//

/// A simple LIFO collection of elements
public struct Queue<Element> {
    private var storage: List<Element>

    public init() {
        storage = List()
    }

    /// Return the number of element in this queue
    public var count: Int { storage.count }

    /// A Boolean value indication whether the queue is empty
    public var isEmpty: Bool { storage.isEmpty }

    /// Add an element to the end of the queue
    public mutating func push(_ element: Element) {
        storage.append(element)
    }

    public mutating func push<S: Sequence>(contentsOf elements: S) where S.Element == Element {
        elements.forEach { push($0) }
    }

    /// Remove an element from the top of the queue and return it.
    /// For an empty queue, return `nil`.
    @discardableResult
    public mutating func pop() -> Element? {
        storage.removeFirst()
    }

    /// Return the top element of the queue without removing it.
    /// For an empty queue, return `nil`.
    public func peek() -> Element? {
        storage.first
    }
}
