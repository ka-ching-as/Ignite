//
// String-HTMLEscaped.swift
// Ignite
// https://www.github.com/twostraws/Ignite
// See LICENSE for license information.
//

extension String {
    /// This string with the characters that have a meaning in HTML text and
    /// attribute values (`&`, `<`, `>` and `"`) replaced by character references.
    func htmlEscaped() -> String {
        var result = ""
        result.reserveCapacity(utf8.count)
        for character in self {
            switch character {
            case "&": result += "&amp;"
            case "<": result += "&lt;"
            case ">": result += "&gt;"
            case "\"": result += "&quot;"
            default: result.append(character)
            }
        }
        return result
    }
}
