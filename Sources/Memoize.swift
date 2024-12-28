//
//  Memoize.swift
//
//  Advent of Code Tools
//

//  from https://forums.swift.org/t/advent-of-code-2023/68749/58

//  usage:

//  let sumOfDigits = memoize(_sumOfDigits)
//  func _sumOfDigits(_ n: Int) -> Int {
//      guard n != 0 else { return 0 }
//      return n % 10 + sumOfDigits(n / 10)
//  }

@MainActor
public func memoize<In: Hashable, Out>(_ f: @MainActor @escaping (In) -> Out) -> (In) -> Out {
    var memo = [In: Out]()
    return {
        if let result = memo[$0] {
            return result
        } else {
            let result = f($0)
            memo[$0] = result
            return result
        }
    }
}

// or, taken from https://forums.swift.org/t/advent-of-code-2024/76301/117

// usage:

//  let sumOfDigits = Memoized<Int, Int> { n, recurse in
//      guard n != 0 else { return 0 }
//      return n % 10 + recurse(n / 10)
//  }
public final class Memoized<In: Hashable, Out> {
    private var _compute: (In, Memoized) -> Out

    public init(_ compute: @escaping (In, Memoized) -> Out) {
        _compute = { _, _ in fatalError() }

        unowned let me = self
        var cache: [In: Out] = [:]
        _compute = { input, _ in
            if let answer = cache[input] {
                return answer
            }
            let answer = compute(input, me)
            cache[input] = answer
            return answer
        }
    }

    public func callAsFunction(_ input: In) -> Out { _compute(input, self) }
}
