//
//  StringTests.swift
//  
//  Advent of Code tools
//

import Testing
import AoCTools

@Suite
struct StringTests {
    @Test func testTrim() throws {
        let str = "  abc   "
        #expect(str.trimmed() == "abc")
    }

    @Test func testIndex() throws {
        let str = "abc"

        #expect(str.indexOf("b") == 1)
        #expect(str.indexOf("x") == nil)
    }

    @Test func testSubscript() throws {
        let str = "abcdef"

        #expect(str[0] == "a")
        #expect(str[1] == "b")
        #expect(str[5] == "f")

        #expect(str[0] == "a")
        #expect(str[1] == "b")
        #expect(str[5] == "f")
    }

    @Test func testSubstring() throws {
        let str = "abcdef"

        #expect(str.substring(0, 2) == "ab")
        #expect(str.substring(3, 2) == "de")
    }

    @Test func testRangeSubscript() throws {
        let str = "abcdef"

        #expect(str[0...1] == "ab")
        #expect(str[3..<5] == "de")
    }

    @Test func testIntegers() throws {
        #expect("1,2,3".integers() == [1, 2, 3])
        #expect("1 red -2 blue 3green".integers() == [1, -2, 3])
        #expect("Game 1: 1 red, 2 bluem 3 green; 4 yellow".integers() == [1, 1, 2, 3, 4])
    }

    @Test func testLines() throws {
        #expect("foo\nbar".lines == ["foo", "bar"])
        #expect("foo\n\nbar".lines == ["foo", "", "bar"])
        #expect("\nfoo\n\nbar\n ".lines == ["", "foo", "", "bar", " "])
    }

    @Test func testGrouped() throws {
        #expect("foo\n\nbar".lines.grouped(by: { $0.isEmpty }) == [["foo"], ["bar"]])
        #expect("foo\nbar\n\nbar\nfoo".lines.grouped(by: { $0.isEmpty }) == [["foo", "bar"], ["bar", "foo"]])
        #expect("foo\n\n\nbar".lines.grouped(by: { $0.isEmpty }) == [["foo"], [], ["bar"]])
        #expect("foo\n\nbar\n\nbaz\n".lines.grouped(by: { $0.isEmpty }) == [["foo"], ["bar"], ["baz"]])
    }
}
