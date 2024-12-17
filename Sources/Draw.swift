//
//  Draw.swift
//
//  Advent of Code Tools
//

public protocol Drawable {
    var draw: Character { get }
    static func value(for ch: Character) -> Self
}

public extension Drawable where Self: RawRepresentable, Self.RawValue == Character {
    static func value(for ch: Character) -> Self {
        Self(rawValue: ch)!
    }

    var draw: Character { rawValue }
}

public extension Drawable where Self: RawRepresentable, Self.RawValue == String {
    static func value(for ch: Character) -> Self {
        Self(rawValue: String(ch))!
    }

    var draw: Character { rawValue.first! }
}

public extension Drawable where Self == Bool {
    static var off: Character { "." }
    static var on: Character { "#" }
}

extension Character: Drawable {
    public var draw: Character { self }
    public static func value(for ch: Character) -> Self { ch }
}

extension Bool: Drawable {
    public var draw: Character { self ? Self.on : Self.off }
    public static func value(for ch: Character) -> Self {
        ch == Self.on
    }
}

extension Dictionary where Key == Point, Value: Drawable {
    public func draw(xRange: ClosedRange<Int>, yRange: ClosedRange<Int>, default: Character = ".") -> [String] {
        yRange.map { y in
            let chars = xRange.map { x in
                self[Point(x, y)]?.draw ?? `default`
            }
            return String(chars)
        }
    }
}
