//
//  LargeNumber.swift
//  Idle Clicker
//
//  Created by Louis Kolodzinski on 26/05/2024.
//

struct LargeNumber: Codable, CustomStringConvertible {
    private var value: Double
    
    private static let suffixes: [String] = [
        "", "Thousand", "Million", "Billion", "Trillion", "Quadrillion", "Quintillion", "Sextillion", "Septillion",
        "Octillion", "Nonillion", "Decillion", "Undecillion", "Duodecillion", "Tredecillion", "Quattuordecillion",
        "Quindecillion", "Sexdecillion", "Septendecillion", "Octodecillion", "Novemdecillion", "Vigintillion"
    ]
    
    var description: String {
        let thousand = 1000.0
        var value = self.value
        var suffixIndex = 0
        
        while value >= thousand && suffixIndex < LargeNumber.suffixes.count - 1 {
            value /= thousand
            suffixIndex += 1
        }
        
        return String(format: "%.2f \(LargeNumber.suffixes[suffixIndex])", value)
    }
    
    init(_ value: Int) {
        self.value = Double(value)
    }

    init(_ value: Double) {
        self.value = value
    }
    
    mutating func add(_ other: LargeNumber) {
        self.value += other.value
    }

    mutating func add(_ value: Int) {
        self.value += Double(value)
    }
    
    mutating func subtract(_ other: LargeNumber) {
        self.value -= other.value
    }

    mutating func subtract(_ value: Int) {
        self.value -= Double(value)
    }
    
    func toIntSafe() -> Int {
        if self.value <= Double(Int.max) {
            return Int(self.value)
        } else {
            let maxValue = Double(Int.max)
            let factor = self.value / maxValue
            return Int(maxValue / factor)
        }
    }

    func toDouble() -> Double {
        return self.value
    }

    static func >= (lhs: LargeNumber, rhs: LargeNumber) -> Bool {
        return lhs.value >= rhs.value
    }

    static func < (lhs: LargeNumber, rhs: LargeNumber) -> Bool {
        return lhs.value < rhs.value
    }

    static func + (lhs: LargeNumber, rhs: LargeNumber) -> LargeNumber {
        return LargeNumber(lhs.value + rhs.value)
    }

    static func - (lhs: LargeNumber, rhs: LargeNumber) -> LargeNumber {
        return LargeNumber(lhs.value - rhs.value)
    }

    static func * (lhs: LargeNumber, rhs: Double) -> LargeNumber {
        return LargeNumber(lhs.value * rhs)
    }

    static func * (lhs: LargeNumber, rhs: LargeNumber) -> LargeNumber {
        return LargeNumber(lhs.value * rhs.value)
    }

    static func / (lhs: LargeNumber, rhs: Double) -> LargeNumber {
        return LargeNumber(lhs.value / rhs)
    }

    static func / (lhs: LargeNumber, rhs: LargeNumber) -> LargeNumber {
        return LargeNumber(lhs.value / rhs.value)
    }
}
