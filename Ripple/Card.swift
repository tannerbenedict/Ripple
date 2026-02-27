//
//  Card.swift
//  Ripple
//
//  Created on 2/26/26.
//

import Foundation

/// Represents a single card in the Ripple game.
enum Card: Equatable, CustomStringConvertible {
    case number(Int)
    case ripple

    var description: String {
        switch self {
        case .number(let value):
            return "\(value)"
        case .ripple:
            return "Ripple"
        }
    }

    /// Whether this card is a Ripple card.
    var isRipple: Bool {
        if case .ripple = self { return true }
        return false
    }

    /// The numeric value of the card, or nil if it's a Ripple card.
    var value: Int? {
        if case .number(let v) = self { return v }
        return nil
    }
}
