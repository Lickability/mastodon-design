//
//  SampleData.swift
//  Design
//
//  Created by Sam on 2024-03-28.
//

import SwiftUI

struct SampleData {
    
    static let sampleAccount = Account(
        id: "1",
        username: "sampleUser",
        server: "example.social",
        displayName: "Sample User",
        avatar: Image("avatar")
    )
    
    static let sampleMediaAttachments = [
        MediaAttachment(type: .photo, fileURL: Bundle.main.url(forResource: "landscape", withExtension: "jpeg")!, altText: "A bunch of little hotel toiletries and samples on my coffee table"),
        MediaAttachment(type: .photo, fileURL: Bundle.main.url(forResource: "portrait", withExtension: "jpeg")!),
        MediaAttachment(type: .photo, fileURL: Bundle.main.url(forResource: "screenshot", withExtension: "png")!),
        MediaAttachment(type: .photo, fileURL: Bundle.main.url(forResource: "ultrawide", withExtension: "jpg")!),
    ]
    
    static let samplePost = Post(
        id: "1",
        createdAt: Date(),
        inReplyToId: nil,
        sensitive: false,
        spoilerText: "",
        visibility: .public,
        uri: "https://example.com/post/1",
        url: "https://example.com/post/1",
        repliesCount: 0,
        boosts: 9,
        favorites: 999,
        content: "Dolor velit minim nisi. Velit ex id mollit est cupidatat. Laboris amet exercitation nostrud cupidatat qui officia dolor pariatur consectetur.",
        isFavorited: false,
        isBoosted: false,
        muted: false,
        bookmarked: false,
        account: sampleAccount,
        reblog: nil,
        postExtra: .media(sampleMediaAttachments)
    )
}
