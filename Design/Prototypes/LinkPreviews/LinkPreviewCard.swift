//
//  LinkPreviewCard.swift
//  Design
//
//  Created by Sam on 2024-06-20.
//

import SwiftUI

struct LinkPreviewCard: View {
    @State private var showDiscussionButton: Bool = true
    @State private var publisher: String = "The Daily Weekly Journal"
    @State private var title: String = "Cow airlifted by helicopter in Swiss Alps"
    @State private var description: String = "A farmer in Switzerland decided to use a helicopter to airlift one of his beloved bovines down the mountain after it became slightly injured."
    @State private var authorName: String = "Sam Henri Gold"
    @State private var authorIsOnMastodon: Bool = true
    @State private var imageUrl: String = "https://cloudfront-us-east-2.images.arcpublishing.com/reuters/BDONMW373RPEZGUBM476GVXI2E.jpg"
    @State private var date: Date = Date()

    private let maxImageHeight: CGFloat = 188
    private let maxCardWidth: CGFloat = 300
    
    var body: some View {
        VStack {
            VStack(alignment: .leading) {
                if let url = URL(string: imageUrl) {
                    AsyncImage(url: url) { phase in
                        switch phase {
                        case .empty:
                            ProgressView()
                                .frame(maxWidth: .infinity, maxHeight: maxImageHeight)
                        case .success(let image):
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(maxWidth: .infinity, maxHeight: maxImageHeight)
                                .clipped()
                        case .failure:
                            Image(systemName: "photo")
                                .font(.largeTitle)
                                .foregroundStyle(.tertiary)
                                .frame(maxWidth: .infinity, maxHeight: maxImageHeight)
                        @unknown default:
                            EmptyView()
                        }
                    }
                } else {
                    Image(systemName: "photo")
                        .font(.largeTitle)
                        .foregroundStyle(.tertiary)
                        .frame(maxWidth: .infinity, maxHeight: maxImageHeight)
                }
                
                CardDescription(publisher: publisher, title: title, description: description, date: date)
                
                CardFooter(authorIsOnMastodon: authorIsOnMastodon, authorName: authorName, showDiscussionButton: showDiscussionButton)
            }
            .frame(maxWidth: maxCardWidth)
            .background(Color(.tertiarySystemFill))
            .clipShape(RoundedRectangle(cornerRadius: 8))
            Spacer()
        }
        .popover(isPresented: .constant(true)) {
            PrototypingSheet(showDiscussionButton: $showDiscussionButton,
                             publisher: $publisher,
                             title: $title,
                             description: $description,
                             authorName: $authorName,
                             authorIsOnMastodon: $authorIsOnMastodon,
                             date: $date)
            .presentationDetents([.height(300), .medium, .large])
            .presentationContentInteraction(.scrolls)
            .presentationBackgroundInteraction(.enabled(upThrough: .large))
        }
    }
}

fileprivate struct CardDescription: View {
    var publisher: String
    var title: String
    var description: String
    var date: Date
    
    private var formattedDate: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        return dateFormatter.string(from: date)
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 2) {
            HStack(spacing: 0) {
                Text(publisher)
                Text(" · ")
                Text(formattedDate)
            }
            .lineLimit(1)
            .font(.footnote)
            .foregroundStyle(.secondary)
            
            Text(title)
                .font(.headline)
                .lineLimit(4)
            
            Text(description)
                .font(.subheadline)
                .lineLimit(2)
        }
        .padding(.horizontal)
        .padding(.vertical, 8)
    }
}

fileprivate struct CardFooter: View {
    var authorIsOnMastodon: Bool
    var authorName: String
    var showDiscussionButton: Bool
    
    var body: some View {
        HStack(spacing: 6) {
            if authorIsOnMastodon {
                Image("mastodon.logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 16, height: 16)
                Text("By")
                Button {} label: {
                    HStack(spacing: 6) {
                        Image("avatar")
                            .resizable()
                            .frame(width: 16, height: 16)
                            .clipShape(RoundedRectangle(cornerRadius: 4))
                        Text(authorName)
                            .foregroundStyle(.primary)
                            .bold()
                    }
                    .font(.footnote)
                    .padding(.horizontal, 6)
                    .padding(.vertical, 4)
                    .background(.indigo.tertiary, in: RoundedRectangle(cornerRadius: 6))
                }
            } else {
                Text("By \(authorName)")
            }
            Spacer(minLength: 0)
            if showDiscussionButton {
                Button {} label: {
                    Label("Show Link Discussion", systemImage: "bubble.left.and.text.bubble.right")
                        .labelStyle(.iconOnly)
                }
            }
        }
        .font(.subheadline)
        .foregroundStyle(.secondary)
        .padding(.leading)
        .padding(.trailing, showDiscussionButton ? 12 : nil)
        .padding(.vertical, 8)
        .frame(maxWidth: .infinity)
        .frame(minHeight: showDiscussionButton ? 44 : nil)
        .lineLimit(1)
        .overlay(alignment: .top) {
            Divider()
        }
    }
}

struct PrototypingSheet: View {
    @Binding var showDiscussionButton: Bool
    @Binding var publisher: String
    @Binding var title: String
    @Binding var description: String
    @Binding var authorName: String
    @Binding var authorIsOnMastodon: Bool
    @Binding var date: Date

    var body: some View {
        Form {
            Toggle("Show Discussion Button", isOn: $showDiscussionButton)
            
            Toggle("Author is on Mastodon", isOn: $authorIsOnMastodon)
            
            DatePicker("Publish Date", selection: $date, displayedComponents: .date)

            Section(header: Text("Text Fields")) {
                TextField("Publisher", text: $publisher)
                TextField("Headline", text: $title)
                TextField("Description", text: $description)
                TextField("Author Name", text: $authorName)
            }
            
        }
    }
}

#Preview {
    LinkPreviewCard()
}
