//
//  NotificationCell.swift
//  Design
//
//  Created by Sam on 2024-05-08.
//

import SwiftUI

enum NotificationType {
    case favorite, boost, follow, pollEnded, lostConnection, announcement
}

struct NotificationCell: View {
    let notificationType: NotificationType
    let users: [Account]
    
    var body: some View {
        HStack(alignment: .top) {
            NotificationIconView(for: notificationType)
            NotificationContentView(notificationType: notificationType, users: users)
        }
        .frame(maxWidth: .infinity)
        .padding([.vertical, .trailing])
        .border(Color.black, width: 1)
    }
}

struct NotificationContentView: View {
    let notificationType: NotificationType
    let users: [Account]
    
    var body: some View {
        switch notificationType {
        case .lostConnection, .announcement:
            TextNotificationView(notificationType: notificationType)
                .font(.callout)
        default:
            SocialNotificationView(users: users, notificationType: notificationType)
        }
    }
}

struct SocialNotificationView: View {
    let users: [Account]
    let notificationType: NotificationType
    
    var body: some View {
        VStack(alignment: .leading) {
            AvatarGroupRow(count: users.count)
            Text(composeSocialText())
                .font(.callout)
            InlinePostPreview(SampleData.samplePost)
        }
    }
    
    private func composeSocialText() -> LocalizedStringKey {
        if users.count == 1 {
            return LocalizedStringKey("**\(users.first!.displayName)** \(actionVerb(for: notificationType)):")
        } else if users.count == 2 {
            return LocalizedStringKey("**\(users.first!.displayName)** and **\(users[1].displayName)** \(actionVerb(for: notificationType)):")
        } else {
            return LocalizedStringKey("**\(users.first!.displayName)** and \(users.count - 1) others \(actionVerb(for: notificationType)):")
        }
    }
    
    private func actionVerb(for type: NotificationType) -> String {
        switch type {
        case .favorite: return "favorited"
        case .boost: return "boosted"
        case .follow: return "followed you"
        case .pollEnded: return "ran a poll that you and 100 others voted in"
        default: return ""
        }
    }
}

@ViewBuilder
func TextNotificationView (notificationType: NotificationType) -> some View {
    switch notificationType {
    case .lostConnection:
        Text("An admin from example.social has blocked mastodon.social, including 4 of your followers and 2 accounts you follow.")
    case .announcement:
        VStack(alignment: .leading) {
            Text("From example.social")
                .bold()
            Text("Looks like there was an issue processing audio attachments without embedded art since yesterday due to an experimental new feature. That issue has now been fixed.")
        }
    default:
        EmptyView()
    }
}

@ViewBuilder
func InlinePostPreview(_ post: Post) -> some View {
    VStack(alignment: .leading) {
        HStack(spacing: 4) {
            RoundedRectangle(cornerRadius: 4)
                .frame(width: 16, height: 16)
            Text(post.account.displayName)
                .bold()
            Text("@\(post.account.username)@\(post.account.server)")
                .foregroundStyle(.secondary)
            Spacer(minLength: 0)
        }
        .lineLimit(1)
        .font(.subheadline)
        Text(post.content)
            .font(.callout)
            .lineLimit(3)
    }
    .padding(8)
    .frame(maxWidth: .infinity)
    .overlay {
        RoundedRectangle(cornerRadius: 8)
            .fill(.clear)
            .stroke(.separator)
    }
}

@ViewBuilder
func NotificationIconView(for type: NotificationType) -> some View {
    Group {
        switch type {
        case .favorite:
            Image(systemName: "star")
        case .boost:
            Image(systemName: "arrow.2.squarepath")
        case .follow:
            Image(systemName: "person.badge.plus")
        case .pollEnded:
            Image(systemName: "chart.bar.xaxis")
        case .lostConnection:
            Image(systemName: "heart.slash")
        case .announcement:
            Image(systemName: "info.circle")
        }
    }
    .font(.title2)
    .frame(width: 44)
    .symbolVariant(.fill)
    .fontWeight(.semibold)
}

@ViewBuilder
func AvatarGroupRow(count: Int) -> some View {
    HStack(alignment: .center) {
        ForEach(0..<count, id: \.self) { _ in
            RoundedRectangle(cornerRadius: 6)
                .frame(width: 28, height: 28)
        }
    }
}

#Preview {
    VStack(alignment: .leading, spacing: 0) {
        NotificationCell(notificationType: .favorite, users: [SampleData.sampleAccount, SampleData.sampleAccount, SampleData.sampleAccount])
        NotificationCell(notificationType: .boost, users: [SampleData.sampleAccount, SampleData.sampleAccount])
        NotificationCell(notificationType: .announcement, users: [])
    }
}
