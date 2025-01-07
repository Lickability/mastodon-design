//
//  ComposerView.swift
//  Design
//
//  Created by Sam Gold on 2025-01-07.
//

import SwiftUI
import Pow

fileprivate enum FocusedField {
    case body, contentWarning
}

struct ComposerView: View {
    @Environment(\.dismiss) var dismiss
    @FocusState private var focusedField: FocusedField?
    @State private var composerModel = MastodonComposerModel(account: SampleData.sampleAccount)
    @State private var isWarningAboutAltText = false
    @Namespace private var scrollSpace
    
    private var firstAttachmentWithoutAlt: MediaAttachment? {
        composerModel.attachments.first { ($0.altText ?? "").isEmpty }
    }
    
    var body: some View {
        NavigationStack {
            ScrollView {
                headerStack()
                    .padding([.horizontal])
                
                TextEditor(text: $composerModel.text)
                    .padding(.horizontal)
                    .padding(.vertical, Design.Grid.s_5)
                    .focused($focusedField, equals: .body)
                
                ScrollViewReader { proxy in
                    ScrollView(.horizontal) {
                        HStack {
                            ForEach(composerModel.attachments) { attachment in
                                MediaAttachmentCard(
                                    attachment: attachment,
                                    onAltTextToggle: { updatedAttachment in
                                        if let index = composerModel.attachments.firstIndex(where: { $0.id == attachment.id }) {
                                            withAnimation(.default.speed(2)) { 
                                                composerModel.attachments[index] = updatedAttachment
                                            }
                                        }
                                    }
                                )
                                .id(attachment.id)
                            }
                        }
                    }
                    .scrollIndicators(.hidden)
                    .contentMargins(.horizontal, Design.Grid.s2, for: .scrollContent)
                    .onChange(of: isWarningAboutAltText) { oldValue, newValue in
                        if oldValue == true && newValue == false {
                            withAnimation {
                                proxy.scrollTo(firstAttachmentWithoutAlt?.id, anchor: .leading)
                            }
                        }
                    }
                }
            }
            .scrollDismissesKeyboard(.interactively)
            .contentMargins(.vertical, Design.Grid.s2, for: .scrollContent)
            .navigationTitle("New Post")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .primaryAction) {
                    Button("Post") {
                        if composerModel.attachments.contains(where: { ($0.altText ?? "").isEmpty }) {
                            isWarningAboutAltText = true
                        } else {
                            dismiss()
                        }
                    }
                    .bold()
                }
            }
            .alert("Add Media Description", isPresented: $isWarningAboutAltText, actions: {
                Button("Post Anyway") {
                    dismiss()
                }
                
                Button("Add Description") {
                    isWarningAboutAltText = false
                }
                .keyboardShortcut(.defaultAction)
            }, message: {
                Text("One or more of your media attachments don’t have alternative descriptions.")
            })
            .task {
                composerModel.text = "-8 C/18 F out 🥶🧱"
                focusedField = .body
            }
        }
    }
    
    @ViewBuilder
    func headerStack() -> some View {
        HStack {
            composerModel.account.avatar
                .resizable()
                .frame(width: 48, height: 48)
                .clipShape(RoundedRectangle(cornerRadius: Design.Grid.s1))
                .overlay {
                    RoundedRectangle(cornerRadius: Design.Grid.s1)
                        .stroke(.separator, lineWidth: 1)
                        .blendMode(.plusLighter)
                }
            
            VStack(alignment: .leading, spacing: 4) {
                HStack(spacing: 4) {
                    Text("sam henri gold")
                        .bold()
                    Text(verbatim: "@samhenrigold@hachyderm.io")
                        .foregroundStyle(.secondary)
                }
                .lineLimit(1)
                
                /*
                 Right, so this looks kinda insane.
                 This is the only way I've been able to figure out how to build this exact view.
                 We need a custom button view so we can make it smaller, which Picker's label closure doesn't let you do.
                 So what we do is we wrap the picker in a menu, which can take a Picker as the menu content. And it becomes an invisible wrapper.
                 */
                Menu {
                    Picker("Visibility", selection: $composerModel.visibility) {
                        ForEach(PostVisibility.allCases, id: \.self) { setting in
                            /*
                             This is also insane.
                             If you look at the picker live, you'll notice that it renders each option nicely with titles, subtitles and images.
                             SwiftUI has this behavior where, if you stick these exact three views in a button, it'll just render it nicely.
                             It works in a menu picker context as well, and so, here we are. Sorry.
                             */
                            Button(action: {}, label: {
                                Text(setting.title)
                                Text(setting.subtitle)
                                Image(systemName: setting.icon)
                            })
                        }
                    }
                } label: {
                    HStack(spacing: Design.Grid.s_5) {
                        Image(systemName: composerModel.visibility.icon)
                        
                        Text(composerModel.visibility.title)
                        
                        Image(systemName: "chevron.up.chevron.down")
                            .font(.caption)
                            .fontWeight(.medium)
                    }
                    .padding(.horizontal, Design.Grid.s1)
                    .padding(.vertical, Design.Grid.s_5)
                    .background(.tertiary, in: RoundedRectangle(cornerRadius: Design.Grid.s1))
                    .font(.subheadline)
                }
            }
        }
        .font(.callout)
        .frame(maxWidth: .infinity, alignment: .topLeading)
    }
}

#Preview {
    ComposerView()
}
