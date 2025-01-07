//
//  PostModel.swift
//  Design
//
//  Created by Sam on 2024-03-28.
//

import SwiftUI
import Photos

/// Represents a user account associated with a post.
/// (Also used by our composer.)
struct Account: Identifiable {
    let id: String
    let username: String
    let server: String
    let displayName: String
    let avatar: Image // SwiftUI Image
    
    init(id: String = UUID().uuidString,
         username: String,
         server: String,
         displayName: String,
         avatar: Image) {
        
        self.id = id
        self.username = username
        self.server = server
        self.displayName = displayName
        self.avatar = avatar
    }
}

/// Represents media attachments in a post.
struct MediaAttachment: Identifiable {
    let id: UUID = UUID()
    let type: PHAssetResourceType
    var fileURL: URL
    var altText: String?
}

enum PostExtra {
    case none
    case media([MediaAttachment])
    case poll(PollData)
}

/// Defines a final published post in the social media app.
struct Post: Identifiable {
    let id: String
    var uri: String
    var content: String
    var account: Account
    
    var repliesCount: Int = 0
    var boosts: Int = 0
    var isBoosted: Bool = false
    var favorites: Int = 0
    var isFavorited: Bool = false
    
    mutating func toggleBoost() {
        isBoosted.toggle()
        boosts += isBoosted ? 1 : -1
    }
    
    mutating func toggleFavorite() {
        isFavorited.toggle()
        favorites += isFavorited ? 1 : -1
    }
    
    mutating func addReply() {
        repliesCount += 1
    }
    
    let createdAt: Date
    let inReplyToId: String?
    let sensitive: Bool
    let spoilerText: String
    let visibility: PostVisibility
    let url: String?
    let muted: Bool
    let bookmarked: Bool
    let postExtra: PostExtra
    
    // Initialize with default values for simplicity
    init(
        id: String = UUID().uuidString,
        createdAt: Date = Date(),
        inReplyToId: String? = nil,
        sensitive: Bool = false,
        spoilerText: String = "",
        visibility: PostVisibility = .public,
        uri: String,
        url: String? = nil,
        repliesCount: Int = 0,
        boosts: Int = 0,
        favorites: Int = 0,
        content: String,
        isFavorited: Bool = false,
        isBoosted: Bool = false,
        muted: Bool = false,
        bookmarked: Bool = false,
        account: Account,
        reblog: Post? = nil,
        postExtra: PostExtra = .none
    ) {
        self.id = id
        self.createdAt = createdAt
        self.inReplyToId = inReplyToId
        self.sensitive = sensitive
        self.spoilerText = spoilerText
        self.visibility = visibility
        self.uri = uri
        self.url = url
        self.repliesCount = repliesCount
        self.boosts = boosts
        self.favorites = favorites
        self.content = content
        self.isFavorited = isFavorited
        self.isBoosted = isBoosted
        self.muted = muted
        self.bookmarked = bookmarked
        self.account = account
        self.postExtra = postExtra
    }
}
