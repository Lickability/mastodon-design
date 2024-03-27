//
//  NumberAbbreviationFormatter.swift
//  MastodonProfile
//
//  Created by Sam on 2024-03-11.
//

import Foundation

class NumberAbbreviationFormatter: Formatter {
    override func string(for obj: Any?) -> String? {
        guard let number = obj as? Int else { return nil }
        
        let numberFormatter = NumberFormatter()
        numberFormatter.maximumFractionDigits = 1
        numberFormatter.minimumFractionDigits = 0
        numberFormatter.numberStyle = .decimal
        
        let suffixes = ["", "K", "M", "B", "T"]
        let index = min(suffixes.count - 1, Int(log10(Double(abs(number)))) / 3)
        let divisor = pow(10.0, Double(index * 3))
        let formattedNumber = Double(number) / divisor
        
        guard let formattedString = numberFormatter.string(from: NSNumber(value: formattedNumber)) else { return nil }
        
        return formattedString + suffixes[index]
    }
}
