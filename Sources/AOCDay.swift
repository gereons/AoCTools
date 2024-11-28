//
//  AOCDay.swift
//
//  Advent of Code Tools
//

@MainActor
public protocol Runnable {
    static var input: String { get }
    init(input: String)
    func run()
}

public protocol AOCDay: Runnable {
    var day: String { get }
    var title: String { get }

    associatedtype Solution1
    func part1() -> Solution1

    associatedtype Solution2
    func part2() -> Solution2
}

extension AOCDay {
    public static var input: String { "" }
    public var day: String { "\(Int("\(Self.self)".suffix(2))!)" }
    public var title: String { "Day \(day)" }

    public func run() {
        run(part: 1, part1)
        run(part: 2, part2)
    }

    private func run<T>(part: Int, _ fun: () -> T) {
        let timer = Timer(day, fun: "'\(title)' part \(part)")
        let solution = fun()
        timer.show()
        print("Solution for day \(day) '\(title)' part \(part): \(solution)")
    }
}
