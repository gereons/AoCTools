import Testing
import AoCTools

import Algorithms

@Suite
struct ArrayTests {
    @Test func testPermutations() throws {
        let array = [1, 2, 3]
        var result = Set<[Int]>()

        array.permutations {
            result.insert($0)
        }

        #expect(result.count == 6)
        #expect(result == [[1, 2, 3], [1, 3, 2], [2, 1, 3], [2, 3, 1], [3, 2, 1], [3, 1, 2]])
    }

    @Test func testChunkBy() throws {
        var numbers = [1]
        #expect(numbers.chunked(by: { $0 <= $1 }) == [[1]])

        #expect([Int]().chunked(by: { $0 <= $1 }).isEmpty)

        numbers = [10, 20, 30, 10, 40, 40, 10, 20]
        var chunks = numbers.chunked { $0 <= $1 }
        #expect(chunks == [[10, 20, 30], [10, 40, 40], [10, 20]])

        numbers = [10, 20, 30]
        chunks = numbers.chunked { $0 <= $1 }
        #expect(chunks == [[10, 20, 30]])

        numbers = [30, 20, 10]
        chunks = numbers.chunked { $0 <= $1 }
        #expect(chunks == [[30], [20], [10]])

        numbers = [10, 40, 40, 10]
        chunks = numbers.chunked { $0 <= $1 }
        #expect(chunks == [[10, 40, 40], [10]])

        numbers = [ 1, 2, 3, 5, 6 ]
        chunks = numbers.chunked { $1 - $0 == 1 }
        #expect(chunks == [[1, 2, 3], [5, 6]])
    }

    @Test func testGroupBy() throws {
        var numbers = [2, 3, 4]
        var groups = numbers.grouped { !$0.isMultiple(of: 2) }
        #expect(groups == [[2], [4]])

        numbers = []
        groups = numbers.grouped { !$0.isMultiple(of: 2) }
        #expect(groups.isEmpty)
    }

    @Test func testSort() throws {
        struct Foo: Equatable {
            let x: Int
        }

        var array = [ Foo(x: 100), Foo(x: 1)]
        #expect(array.sorted(by: \.x) == array.reversed())

        array = [ Foo(x: 1), Foo(x: 2)]
        array.sort(by: \.x, using: >)
        #expect(array[0].x == 2)

        array.sort(by: \.x)
        #expect(array[0].x == 1)
    }

    @Test func testMinMax() throws {
        struct Foo: Equatable {
            let x: Int
        }

        let array = [ Foo(x: 100), Foo(x: 1)]
        #expect(array.min(of: \.x) == 1)
        #expect(array.max(of: \.x) == 100)
    }

    @Test func testMedian() throws {
        #expect([1, 1, 3, 5, 8].median() == 3)
        #expect([1.0, 1.0, 3.0, 5.0, 8.0].median() == 3.0)

        #expect([1, 1, 3, 5, 8, 11].median() == 4)
        #expect([1.0, 1.0, 3.0, 5.0, 8.0, 11.0].median() == 4.0)
    }

    @Test func testDictionary() throws {
        struct Foo: Equatable {
            let x: Int
        }

        let array = [ Foo(x: 100), Foo(x: 1) ]

        let dict = array.mapped(by: \.x)

        #expect(dict[1]?.x == 1)
        #expect(dict[100]?.x == 100)
        #expect(dict[2] == nil)
    }

    func testMakeSet() throws {
        #expect([1, 2, 3].makeSet() == Set([1, 2, 3]))
    }
}
