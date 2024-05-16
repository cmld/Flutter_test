//
//  BloomFilter.swift
//  Runner
//
//  Created by yl on 2024/5/14.
//

import Foundation

class BloomFilter {
    private var bitArray: [Bool]
    private let hashFunctionsCount: Int
    
    init(size: Int, hashFunctionsCount: Int) {
        self.bitArray = Array(repeating: false, count: size)
        self.hashFunctionsCount = hashFunctionsCount
    }
    
    func add(_ element: String) {
        for i in 0..<hashFunctionsCount {
            let hashValue = hash(element, i)
            bitArray[hashValue] = true
        }
    }
    
    func contains(_ element: String) -> Bool {
        for i in 0..<hashFunctionsCount {
            let hashValue = hash(element, i)
            if !bitArray[hashValue] {
                return false
            }
        }
        return true
    }
    
    private func hash(_ element: String, _ seed: Int) -> Int {
        var combinedHash = seed
        for char in element.utf8 {
            combinedHash = (combinedHash &* 31) &+ Int(char)
        }
        return (combinedHash & 0x7FFFFFFF) % bitArray.count
    }
}
