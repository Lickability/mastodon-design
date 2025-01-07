//
//  PollModel.swift
//  Design
//
//  Created by Sam Gold on 2025-01-07.
//

import Foundation

enum PollDuration: String, CaseIterable {
    case minutes5     = "5 minutes"
    case minutes30    = "30 minutes"
    case hour1        = "1 hour"
    case hours6       = "6 hours"
    case hours12      = "12 hours"
    case day1         = "1 day"
    case days3        = "3 days"
    case days7        = "7 days"
}

/// Poll style: single choice or multiple choice.
enum PollStyle: String, CaseIterable {
    case singleChoice    = "Single choice"
    case multipleChoice  = "Multiple choice"
}

/// Represents the data needed for a poll.
/// - The poll must have at least two options.
/// - It can have up to four options.
/// - The user picks a duration from `PollDuration`.
/// - The user picks a `PollStyle`.
struct PollData {
    var options: [String] = ["", ""]
    var duration: PollDuration = .day1
    var style: PollStyle = .singleChoice
}
