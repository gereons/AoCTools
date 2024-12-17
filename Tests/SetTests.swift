//
//  SetTests.swift
//  
//  Advent of Code tools
//

import Testing
import AoCTools

@Suite
struct SetTests {
    @Test func testAdd() throws {
        let s1 = Set([1, 2])
        let s2 = Set([3, 4])
        #expect(s1 + s2 == Set([1, 2, 3, 4]))

        #expect(s1 + 4 == Set([1, 2, 4]))

        var s3 = Set([1, 2, 3])
        s3 += 0
        #expect(s3 == Set([1, 2, 3, 0]))

        s3 += s2
        #expect(s3 == Set([1, 2, 3, 0, 4]))
    }

    @Test func testSubtract() throws {
        let s1 = Set([1, 2, 3, 4])
        let s2 = Set([3, 4])
        #expect(s1 - s2 == Set([1, 2]))

        #expect(s1 - 4 == Set([1, 2, 3]))
    }

    @Test func testCombinations() throws {
        let s1 = Set([1, 2, 3])
        let combinations = s1.combinations()
        #expect(combinations.count == 7)

        #expect(combinations.contains([1]))
        #expect(combinations.contains([2]))
        #expect(combinations.contains([3]))
        #expect(combinations.contains([1, 2]))
        #expect(combinations.contains([1, 3]))
        #expect(combinations.contains([2, 3]))
        #expect(combinations.contains([1, 2, 3]))
    }
}
