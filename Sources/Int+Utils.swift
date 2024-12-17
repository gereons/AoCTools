//
//  Int+Utils.swift
//  
//  Advent of Code Tools
//

import Foundation

/// Greatest Common Divisor
/// - Parameters:
///   - m: Int
///   - n: Int
/// - Returns: the greatest common divisor of `m` and `n`
public func gcd(_ m: Int, _ n: Int) -> Int {
    let r = m % n
    return r != 0 ? gcd(n, r) : n
}

/// Lowest Common Multiple
/// - Parameters:
///   - m: Int
///   - n: Int
/// - Returns: the lowest common multiple of `m` and `n`
public func lcm(_ m: Int, _ n: Int) -> Int {
    m / gcd(m, n) * n
}

/// Exponentiation
/// - Parameters:
///   - base: Int
///   - exponent: Int
/// - Returns: the result of `base` to the power of `exponent`
public func pow(_ base: Int, _ exponent: Int) -> Int {
    Int(Foundation.pow(Double(base), Double(exponent)))
}
