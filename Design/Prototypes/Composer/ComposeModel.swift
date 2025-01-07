//
//  ComposeModel.swift
//  Design
//
//  Created by Sam Gold on 2025-01-07.
//

import SwiftUI
import Observation

/// The primary data model for the post composer
@Observable
class MastodonComposerModel {
    
    /// The account from which this post will be sent.
    var account: Account
    
    /// The main text of the post (the “toot”).
    var text: String
    
    /// Optional content warning (CW)
    var contentWarning: String?
    
    /// The language of the post.
    var language: Locale.Language
    
    /// The chosen post visibility.
    var visibility: PostVisibility
    
    var attachments: [MediaAttachment]
    
    /// Designated initializer.
    init(account: Account,
         text: String = "",
         contentWarning: String? = nil,
         language: Locale.Language = .init(languageCode: "en"),
         visibility: PostVisibility = .public,
         attachments: [MediaAttachment] = SampleData.sampleMediaAttachments) {
        
        self.account = account
        self.text = text
        self.contentWarning = contentWarning
        self.language = language
        self.visibility = visibility
        self.attachments = attachments
    }
}
