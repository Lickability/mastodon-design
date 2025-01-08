//
//  MediaAttachmentCard.swift
//  Design
//
//  Created by Sam Gold on 2025-01-07.
//

import SwiftUI

struct MediaAttachmentCard: View {
    var attachment: MediaAttachment?
    var onAltTextToggle: (MediaAttachment) -> Void
    
    private var altTextIsEmpty: Bool {
        attachment?.altText?.isEmpty ?? true
    }
    
    var body: some View {
        ZStack {
            if let url = attachment?.fileURL {
                AsyncImage(url: url) { phase in
                    if let image = phase.image {
                        ZStack(alignment: .bottomLeading) {
                            image
                                .resizable()
                                .scaledToFill()
                                .frame(width: 240, height: 280)
                            
                            Button {
                                var updatedAttachment = attachment
                                if attachment?.altText == nil {
                                    updatedAttachment?.altText = "."
                                } else {
                                    updatedAttachment?.altText = nil
                                }
                                onAltTextToggle(updatedAttachment!)
                            } label: {
                                HStack(spacing: Design.Grid.s_5) {
                                    if altTextIsEmpty {
                                        Image(systemName: "exclamationmark.triangle.fill")
                                            .accessibilityHidden(true)
                                    }
                                    Text("Alt")
                                        .textCase(.uppercase)
                                }
                            }
                            .imageScale(.small)
                            .fontWeight(.heavy)
                            .foregroundStyle(.white)
                            .tint(altTextIsEmpty ? AnyShapeStyle(.pink.gradient) : AnyShapeStyle(.black.opacity(0.8)))
                            .controlSize(.small)
                            .buttonStyle(.borderedProminent)
                            .buttonBorderShape(.roundedRectangle)
                            .padding([.leading, .bottom], Design.Grid.s1)
                            
                            VStack {
                                Button("Delete Attachment", systemImage: "xmark.circle.fill", action: { })
                                    .labelStyle(.iconOnly)
                                    .accessibilityHint(Text("Removes the attachment from your post"))
                                    .font(.title)
                                    .foregroundStyle(.white, .black.opacity(0.8))
                                
                                Spacer()
                            }
                            .frame(maxWidth: .infinity, alignment: .trailing)
                            .padding([.trailing, .top], Design.Grid.s_5)
                        }
                    } else if phase.error != nil {
                        ZStack {
                            Rectangle().fill(.quaternary)
                            ContentUnavailableView("Upload Failed", systemImage: "photo.badge.exclamationmark.fill", description: Text(phase.error?.localizedDescription ?? ""))
                        }
                        .frame(width: 240, height: 280)
                    } else {
                        ZStack {
                            Rectangle().fill(.quaternary)
                            ProgressView()
                        }
                        .frame(width: 240, height: 280)
                    }
                }
            }
        }
        .frame(width: 240, height: 280)
        .clipShape(RoundedRectangle(cornerRadius: Design.Grid.s1))
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    @Previewable @State var attachment = SampleData.sampleMediaAttachments[1]
    
    MediaAttachmentCard(attachment: attachment, onAltTextToggle: { updatedAttachment in
        attachment = updatedAttachment
    })
}
