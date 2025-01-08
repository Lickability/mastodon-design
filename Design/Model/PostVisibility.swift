//
//  PostVisibility.swift
//  Design
//
//  Created by Sam Gold on 2025-01-07.
//

import Foundation

/// Supported visibility levels for a Mastodon post.
enum PostVisibility: CaseIterable {
    case `public`
    case quietPublic
    case followers
    case specificPeople
    
    var mastodonRawValue: String {
        switch self {
        case .public:
            return "public"
        case .quietPublic:
            return "unlisted"
        case .followers:
            return "private"
        case .specificPeople:
            return "direct"
        }
    }
    
    init?(fromRawValue raw: String) {
        switch raw {
        case "public":   self = .public
        case "unlisted": self = .quietPublic
        case "private":  self = .followers
        case "direct":   self = .specificPeople
        default:
            return nil
        }
    }
    
    /// SF Symbol name
    var icon: String {
        switch self {
        case .public:
            return "globe"
        case .quietPublic:
            return "moon.fill"
        case .followers:
            return "lock.fill"
        case .specificPeople:
            return "at"
        }
    }
    
    var title: String {
        switch self {
        case .public:
            return "Public"
        case .quietPublic:
            return "Quiet Public"
        case .followers:
            return "Followers"
        case .specificPeople:
            return "Specific people"
        }
    }
    
    var subtitle: String {
        switch self {
        case .public:
            return "Anyone on and off Mastodon"
        case .quietPublic:
            return "Fewer algorithmic fanfares"
        case .followers:
            return "Only your followers"
        case .specificPeople:
            return "Everyone mentioned in the post"
        }
    }
}
