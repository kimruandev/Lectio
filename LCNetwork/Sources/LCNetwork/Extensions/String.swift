//
//  String.swift
//  LCNetwork
//
//  Created by Kim Lopes on 10/09/26.
//

import Foundation
import UIKit

public extension String {
    var trimming: String {
        return trimmingCharacters(in: .whitespacesAndNewlines)
    }

    var isBlank: Bool {
        return trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }

    var numbersOnly: String {
        return components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
    }

    var isValidMobileNumber: Bool {
        if self.count == 15 {
            let pattern = "^\\([1-9]{2}\\)\\s?9\\d{4}[-\\s]\\d{4}$"
            let regex = try? NSRegularExpression(pattern: pattern)
            let range = NSRange(location: 0, length: self.utf16.count)
            return regex?.firstMatch(in: self, options: [], range: range) != nil
        } else {
            return false
        }
    }
    
    var isValidEmail: Bool {
        let regex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let predicate = NSPredicate(format:"SELF MATCHES %@", regex)
        return predicate.evaluate(with: self)
    }
    
    var isNumbersOnly: Bool {
        return String(self) == components(separatedBy: CharacterSet.decimalDigits.inverted).joined(separator: "")
    }
    
    var isValidCpf: Bool {
        let numbers = self.compactMap( {Int(String($0))} )
        guard numbers.count == 11 && Set(numbers).count != 1 else { return false }
        let firstDigitSum = 11 - ( numbers[0] * 10 +
            numbers[1] * 9 +
            numbers[2] * 8 +
            numbers[3] * 7 +
            numbers[4] * 6 +
            numbers[5] * 5 +
            numbers[6] * 4 +
            numbers[7] * 3 +
            numbers[8] * 2 ) % 11
        let firstDivision = firstDigitSum > 9 ? 0 : firstDigitSum
        let secondDigitSum = 11 - ( numbers[0] * 11 +
            numbers[1] * 10 +
            numbers[2] * 9 +
            numbers[3] * 8 +
            numbers[4] * 7 +
            numbers[5] * 6 +
            numbers[6] * 5 +
            numbers[7] * 4 +
            numbers[8] * 3 +
            numbers[9] * 2 ) % 11
        let secondDivision = secondDigitSum > 9 ? 0 : secondDigitSum
        return firstDivision == numbers[9] && secondDivision == numbers[10]
    }
    
    func convertToCamelCase() -> String {
        let components = self.lowercased().split(separator: "_")
        let first = components.first ?? ""
        let rest = components.dropFirst().map { $0.capitalized }
        return ([String(first)] + rest).joined()
    }

    var boolValue: Bool {
        Bool(self) ?? false
    }
}

public extension String {
    var int: Int {
        Int(self) ?? 0
    }
    
    var double: Double {
        Double(self) ?? 0
    }
}

public extension String {
    func size(usingFont font: UIFont) -> CGSize {
        let fontAttributes = [NSAttributedString.Key.font: font]
        return size(withAttributes: fontAttributes)
    }

    func width(usingFont font: UIFont) -> CGFloat {
        return size(usingFont: font).width
    }

    func height(usingFont font: UIFont) -> CGFloat {
        return size(usingFont: font).height
    }

    var isNotEmpty: Bool {
        return !isEmpty
    }
}

public extension String {
    func formattedCurrency() -> String? {
        guard let valueCents = Double(self) else { return nil }
        let valueReais = valueCents / 100.0
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = Locale(identifier: "pt_BR")
        guard let formattedValue = formatter.string(from: NSNumber(value: valueReais)) else { return nil }
        return formattedValue
    }
}

public extension String {
    var base64ToImage: UIImage? {
        guard let decodedData = NSData(base64Encoded: self, options: []),
              let image = UIImage(data: decodedData as Data) else {
            return nil
        }
        return image
    }
    
    var base64ToData: Data? {
        return Data(base64Encoded: self, options: .ignoreUnknownCharacters)
    }
    
    func split(with regex: String) -> [String] {
        do {
            let regex = try NSRegularExpression(pattern: regex, options: .caseInsensitive)
            let range = NSRange(location: 0, length: self.utf16.count)
            let matches = regex.matches(in: self, options: [], range: range)

            var splittedSentences: [String] = []

            for match in matches {
                if let range = Range(match.range, in: self) {
                    let stringMatchingRegex = String(self[range])
                    splittedSentences.append(stringMatchingRegex)
                }
            }
            return splittedSentences
        } catch {
            debugPrint("Error creating regular expression: \(error.localizedDescription)")
            return []
        }
    }
}

extension String {
    public var attributedString: NSAttributedString {
        return NSAttributedString(string: self)
    }
}

extension String {
    public func limitLenght(_ limit: Int) -> String {
        String(prefix(limit))
    }
}

public extension String {
    var isValidName: Bool {
        let regex = "^[A-Za-z]{2,}(?: [A-Za-z]{1,})+\\s*$"
        return NSPredicate(format: "SELF MATCHES %@", regex).evaluate(with: self)
    }
    
    func unaccent() -> String {
        return self.folding(options: .diacriticInsensitive, locale: .current)
    }
    
    var descriptionForAnalytics: String? {
        unaccent().lowercased().replacingOccurrences(of: " ", with: "-")
    }
    
    func replace(of: String, with: String) -> String {
        replacingOccurrences(of: of, with: with)
    }
}

public extension String {
    func applyMaskToText(apply mask: String?) -> String? {
        var masked = ""
        var textIndex = 0
        var maskIndex = 0

        guard let mask = mask else {
            return nil
        }

        let onlyChars = self.onlyDigits

        while maskIndex < mask.count, textIndex < onlyChars.count {
            var char = mask[mask.index(mask.startIndex, offsetBy: maskIndex)]

            if char == "#" {
                char = onlyChars[self.index(onlyChars.startIndex, offsetBy: textIndex)]
                textIndex += 1
            }

            masked.append(char)
            maskIndex += 1
        }

        return masked
    }

    var onlyDigits: String {
        return replacingOccurrences(of: "\\D", with: "", options: .regularExpression)
    }
    
    var msisdnWithoutCountryCode: String {
        let onlyDigits = self.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
        return String(onlyDigits.suffix(11))
    }
}
