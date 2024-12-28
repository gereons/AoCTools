//
//  String.swift
//
//  Advent of Code Tools
//

import RegexBuilder

extension String {
    public func trimmed() -> String {
        trimmingCharacters(in: .whitespacesAndNewlines)
    }

    public func substring(_ start: Int, _ len: Int) -> String {
        let end = index(startIndex, offsetBy: start + len)
        let start = index(startIndex, offsetBy: start)
        return String(self[start..<end])
    }

    public func indexOf(_ substr: String) -> Int? {
        guard let range = self.range(of: substr) else {
            return nil
        }

        return distance(from: startIndex, to: range.lowerBound)
    }
}

// subscripts
extension String {
    public subscript(_ idx: Int) -> Element {
        self[index(startIndex, offsetBy: idx)]
    }

    public subscript(range: ClosedRange<Int>) -> String {
        substring(range.lowerBound, range.upperBound - range.lowerBound + 1)
    }

    public subscript(range: Range<Int>) -> String {
        substring(range.lowerBound, range.upperBound - range.lowerBound)
    }
}

// splitting
extension String {
    public var lines: [String] {
        split(omittingEmptySubsequences: false, whereSeparator: \.isNewline).map { String($0) }
    }

    public func integers() -> [Int] {
        let regex = Regex {
            TryCapture {
                Optionally("-")
                ZeroOrMore(.digit)
            } transform: {
                Int($0)
            }
        }

        return matches(of: regex).map(\.output.1)
    }
}
