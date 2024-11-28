//
//  DayTests.swift
//  
//  Advent of Code tools
//

import Testing
import AoCTools

final class Day98: AOCDay {
    let input: String

    init(input: String) {
        self.input = input
    }

    func part1() -> Int { 98 }
    func part2() -> String { input }
}

final class Day99: AOCDay {
    let input: String
    let title = "Day99"

    init(input: String) {
        self.input = input
    }

    func part1() -> Int { 99 }
    func part2() -> String { input }
}

extension Day99 {
    static let input = "day99data"
}

// no Day98 extension
@MainActor @Suite
final class DayTests {
    @Test func testDayWithInput() throws {
        let d99 = Day99(input: Day99.input)
        #expect(d99.day == "99")
        #expect(d99.input == Day99.input)
        #expect(d99.part1() == 99)
        #expect(d99.part2() == Day99.input)

        let d99b = Day99(input: "testinput")
        #expect(d99b.day == "99")
        #expect(d99b.input == "testinput")
        #expect(d99b.part1() == 99)
        #expect(d99b.part2() == "testinput")
        #expect(d99b.title == "Day99")
    }

    @Test func testDayWithoutInput() throws {
        let d98 = Day98(input: "test")
        #expect(d98.day == "98")
        #expect(d98.input == "test")
        #expect(Day98.input.isEmpty)
        #expect(d98.part1() == 98)
        #expect(d98.part2() == "test")
        #expect(d98.title == "Day 98")

        let d98b = Day98(input: Day98.input)
        #expect(d98b.day == "98")
        #expect(d98b.input.isEmpty)
        #expect(d98b.part1() == 98)
        #expect(d98b.part2().isEmpty)
    }
}
