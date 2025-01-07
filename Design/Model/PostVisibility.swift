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
    
    /// The raw string value that your backend or Mastodon-like server expects.
    /// (Mastodon: "public", "unlisted", "private", "direct")
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
    
    /// An optional reverse initializer, if you ever receive a raw string from the server
    /// and want to convert it back to `PostVisibility`.
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
    
    /// SF Symbol name, or any icon you'd like to use in the UI
    var icon: String {
        switch self {
        case .public:
            return "globe"
        case .quietPublic:
            return "globe.americas.fill"
        case .followers:
            return "person.2.fill"
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
