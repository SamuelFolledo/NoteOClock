//
//  EditableTextView.swift
//  NoteOClock
//
//  Created by Samuel Folledo on 9/17/23.
//

import SwiftUI

struct EditableTextView: View {
    @ObservedObject var card: Card

    @State private var placeHolderText = "Enter text here"
    @FocusState private var isTextEditing: Bool

    var body: some View {
        ZStack {
            let showPlaceholderText = !isTextEditing && card.text.isEmpty
            if showPlaceholderText {
                TextEditor(text: $placeHolderText)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .padding()
                    .background(Color(UIColor.clear))
                    .foregroundColor(Color(uiColor: .gray))
                    .opacity(0.8)
                    .disabled(true)
            }

            TextEditor(text: $card.text)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .padding()
                .background(Color(UIColor.clear))
                .cornerRadius(8)
                .autocapitalization(.sentences)
                .autocorrectionDisabled()
                .foregroundColor(card.foregroundColor)
                .focused($isTextEditing)
                .onAppear {
                    isTextEditing = card.isSelected
                }
                .onChange(of: card.isSelected) {
                    isTextEditing = $0
                }
                .opacity(showPlaceholderText ? 0 : 1)
        }
    }
}

struct EditableTextView_Previews: PreviewProvider {
    static var previews: some View {
        EditableTextView(card: fakeTextCard)
            .preferredColorScheme(.dark)
    }
}
