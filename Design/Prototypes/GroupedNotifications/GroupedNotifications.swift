//
//  GroupedNotifications.swift
//  Design
//
//  Created by Sam on 2024-05-08.
//

import SwiftUI


enum NotificationType {
    case favorite, boost, follow, pollEnded, lostConnection, announcement, moderation
}

struct GroupedNotifications: View {
    @State private var announcementFullTextPresented = false
    let announcementFullText = "Looks like there was an issue processing audio attachments without embedded art since yesterday due to an experimental new feature. That issue has now been fixed, so you may see older posts with audio from other servers pop up in your feeds now as they are being finally properly processed. Sorry!"
    
    var body: some View {
        List {
            NotificationCell(type: .lostConnection, isUnread: true) {
                VStack(alignment: .leading, spacing: 8) {
                    Text("An admin from **example.social** has blocked **mastodon.social**, including 4 of your followers and 2 accounts you follow.")
                    Button("Learn More", action: {})
                        .buttonStyle(.plain)
                        .bold()
                        .foregroundStyle(.accent)
                }
            }
            NotificationCell(type: nil, isUnread: true) {
                TimelinePostCell(includePadding: false)
            }
            .foregroundStyle(.primary)
            NotificationCell(type: .announcement, isUnread: true) {
                Text("From example.social:")
                    .font(.headline)
                VStack(alignment: .leading, spacing: 8) {
                    Text(announcementFullText)
                        .lineLimit(5)
                    Button("Read More", action: {
                        announcementFullTextPresented = true
                    })
                    .buttonStyle(.plain)
                    .bold()
                    .foregroundStyle(.accent)
                    .sheet(isPresented: $announcementFullTextPresented, content: {
                        NavigationStack {
                            ScrollView {
                                VStack(alignment: .leading) {
                                    Text(announcementFullText)
                                    Text("\nShared today at 9:00 AM by the example.social admins.")
                                        .font(.subheadline)
                                        .foregroundStyle(.secondary)
                                }
                                .padding()
                            }
                            .navigationTitle("From example.social")
                            .navigationBarTitleDisplayMode(.inline)
                            .toolbar {
                                ToolbarItem(placement: .confirmationAction) {
                                    Button("Done") {
                                        announcementFullTextPresented = false
                                    }
                                }
                            }
                        }
                        .presentationDragIndicator(.visible)
                    })
                }
            }
            NotificationCell(type: .favorite, isUnread: false) {
                AvatarGroupRow(count: 6)
                Text("**Full Name** and 5 others favorited:")
                InlinePostPreview(post: SampleData.samplePost)
            }
            NotificationCell(type: .boost, isUnread: false) {
                AvatarGroupRow(count: 2)
                Text("**Full Name** and **Other Name** boosted:")
                InlinePostPreview(post: SampleData.samplePost)
            }
            NotificationCell(type: .follow, isUnread: false) {
                AvatarGroupRow(count: 7) // 8 is maximum but start popping avatars from the end as we run out of space.
                Text("**Full Name** and 30 others followed you")
            }
            NotificationCell(type: .follow, isUnread: false) {
                HStack {
                    AvatarGroupRow(count: 1)
                    Button("Follow Back") {}
                        .buttonStyle(.borderedProminent)
                        .controlSize(.small)
                        .bold()
                }
                Text("**Full Name** followed you")
            }
            NotificationCell(type: .pollEnded, isUnread: false) {
                Text("**Full Name** ran a poll that you and 100 others voted in")
                InlinePostPreview(post: SampleData.samplePost)
            }
        }
        .listStyle(.plain)
    }
}

struct NotificationCell<Content: View>: View {
    let type: NotificationType?
    let isUnread: Bool
    @ViewBuilder let content: Content
    
    var body: some View {
        HStack(alignment: .top) {
            if type != nil {
                NotificationIconView(for: type!)
            }
            VStack(alignment: .leading) {
                content
            }
            Spacer(minLength: 0)
        }
        .frame(maxWidth: .infinity)
        .padding()
        .overlay(alignment: .bottom, content: {
            Divider()
        })
        .listRowInsets(EdgeInsets())
        .listRowSeparator(.hidden)
        .background(isUnread ? .accent.opacity(0.1) : .clear)
    }
}

@ViewBuilder
func AvatarGroupRow(count: Int) -> some View {
    @ScaledMetric var imageSize: CGFloat = 32
    let avatarShape = RoundedRectangle(cornerRadius: 8)
    
    HStack(alignment: .center) {
        ForEach(0..<count, id: \.self) { _ in
            AsyncImage(
                url: URL(string: "https://i.pravatar.cc/96")!,
                content: { image in
                    image.resizable()
                        .aspectRatio(contentMode: .fit)
                        .clipShape(avatarShape)
                },
                placeholder: {
                    avatarShape
                        .foregroundStyle(Color(UIColor.secondarySystemFill))
                }
            )
            .frame(width: imageSize, height: imageSize)
        }
        Spacer(minLength: 0)
    }
}

@ViewBuilder
func NotificationIconView(for type: NotificationType) -> some View {
    HStack {
        switch type {
        case .favorite:
            Image(systemName: "star")
                .foregroundStyle(.orange)
        case .boost:
            Image(systemName: "arrow.2.squarepath")
                .foregroundStyle(.green)
        case .follow:
            Image(systemName: "person.badge.plus")
                .foregroundStyle(.accent)
        case .pollEnded:
            Image(systemName: "chart.bar.xaxis")
                .foregroundStyle(.secondary)
        case .announcement:
            Image(systemName: "info.circle")
                .foregroundStyle(.accent)
        case .lostConnection:
            Image(systemName: "person.badge.minus")
                .foregroundStyle(.secondary)
        case .moderation:
            Image(systemName: "exclamationmark.shield")
                .foregroundStyle(.accent)
        }
    }
    .font(.system(size: 25))
    .frame(width: 44)
    .symbolVariant(.fill)
    .fontWeight(.semibold)
}

#Preview {
    GroupedNotifications()
}
