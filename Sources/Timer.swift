//
//  Timer.swift
//
//  Advent of Code Tools
//

import Foundation
import Synchronization

public struct Timer {
    private let start = Date().timeIntervalSinceReferenceDate
    private let name: String

    private static let total = Mutex<TimeInterval>(0)

    private static let formatter: NumberFormatter = {
        let fmt = NumberFormatter()
        fmt.maximumFractionDigits = 3
        fmt.locale = Locale(identifier: "en_US")
        return fmt
    }()

    public init(_ day: String, fun: String) {
        self.name = "Day \(day) \(fun)"
    }

    public func show() {
        let elapsed = Date().timeIntervalSinceReferenceDate - start
        Self.total.withLock {
            $0 += elapsed
        }
        print("\(name) took \(Self.formatted(elapsed))")
    }

    public static func showTotal() {
        let total = Self.total.withLock { $0 }
        print("Total time: \(formatted(total))")
    }

    private static func formatted(_ interval: TimeInterval) -> String {
        return "\(formatter.string(for: interval * 1000)!)ms"
    }
}
