import XCTest
import AoCTools

final class ArrayTests: XCTestCase {
    func testPermutations() throws {
        let array = [1, 2, 3]
        var result = Set<[Int]>()

        array.permutations {
            result.insert($0)
        }

        XCTAssertEqual(result.count, 6)
        XCTAssertEqual(result, [[1, 2, 3], [1, 3, 2], [2, 1, 3], [2, 3, 1], [3, 2, 1], [3, 1, 2]])
    }

    func testChunkSize() throws {
        XCTAssertEqual([1, 2, 3].chunked(2), [[1, 2], [3]])
        XCTAssertEqual([1, 2, 3, 4].chunked(2), [[1, 2], [3, 4]])
        XCTAssertEqual([1, 2, 3, 4, 5].chunked(2), [[1, 2], [3, 4], [5]])
    }

    func testChunkBy() throws {
        var numbers = [10, 20, 30, 10, 40, 40, 10, 20]
        var chunks = numbers.chunked(by: { $0 <= $1 })
        XCTAssertEqual(chunks, [[10, 20, 30], [10, 40, 40], [10, 20]])

        numbers = [10, 20, 30]
        chunks = numbers.chunked(by: { $0 <= $1 })
        XCTAssertEqual(chunks, [[10, 20, 30]])

        numbers = [30, 20, 10]
        chunks = numbers.chunked(by: { $0 <= $1 })
        XCTAssertEqual(chunks, [[30], [20], [10]])

        numbers = [10, 40, 40, 10]
        chunks = numbers.chunked(by: { $0 <= $1 })
        XCTAssertEqual(chunks, [[10, 40, 40], [10]])
    }

    func testSort() throws {
        struct Foo: Equatable {
            let x: Int
        }

        var array = [ Foo(x: 100), Foo(x: 1)]
        XCTAssertEqual(array.sorted(by: \.x), array.reversed())

        array = [ Foo(x: 1), Foo(x: 2)]
        array.sort(by: \.x, using: >)
        XCTAssertEqual(array[0].x, 2)

        array.sort(by: \.x)
        XCTAssertEqual(array[0].x, 1)
    }

    func testMinMax() throws {
        struct Foo: Equatable {
            let x: Int
        }

        let array = [ Foo(x: 100), Foo(x: 1)]
        XCTAssertEqual(array.min(of: \.x), 1)
        XCTAssertEqual(array.max(of: \.x), 100)
    }

    func testMedian() throws {
        XCTAssertEqual([1, 1, 3, 5, 8].median(), 3)
        XCTAssertEqual([1.0, 1.0, 3.0, 5.0, 8.0].median(), 3.0)

        XCTAssertEqual([1, 1, 3, 5, 8, 11].median(), 4)
        XCTAssertEqual([1.0, 1.0, 3.0, 5.0, 8.0, 11.0].median(), 4.0)
    }

    func testDictionary() throws {
        struct Foo: Equatable {
            let x: Int
        }

        let array = [ Foo(x: 100), Foo(x: 1) ]

        let dict = array.mapped(by: \.x)

        XCTAssertEqual(dict[1]?.x, 1)
        XCTAssertEqual(dict[100]?.x, 100)
        XCTAssertEqual(dict[2], nil)
    }

    func testPairs() throws {
        let pairs = [1, 2, 3, 4].adjacentPairs()
        // [(1,2), (2,3), (3,4)])
        XCTAssertEqual(pairs.count, 3)
        XCTAssertEqual(pairs[0].0, 1)
        XCTAssertEqual(pairs[0].1, 2)
        XCTAssertEqual(pairs[1].0, 2)
        XCTAssertEqual(pairs[1].1, 3)
        XCTAssertEqual(pairs[2].0, 3)
        XCTAssertEqual(pairs[2].1, 4)
    }

    func testMakeSet() throws {
        XCTAssertEqual([1, 2, 3].makeSet(), Set([1, 2, 3]))
    }

    func testCombinations() throws {
        XCTAssertEqual([1, 2, 3].combinations(of: 2), [[1, 2], [1, 3], [2, 3]])
        XCTAssertEqual([1, 2, 3, 4].combinations(of: 2), [[1, 2], [1, 3], [1, 4], [2, 3], [2, 4], [3, 4]])
        XCTAssertEqual([1, 2, 3, 4].combinations(of: 3), [[1, 2, 3], [1, 2, 4], [1, 3, 4], [2, 3, 4]])
        XCTAssertEqual([1, 2, 3, 4].combinations(of: 4), [[1, 2, 3, 4]])
        XCTAssertEqual([1, 2, 3, 4].combinations(of: 5), [])
    }
}
