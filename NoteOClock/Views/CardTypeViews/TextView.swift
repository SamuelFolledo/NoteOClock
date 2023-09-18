//
//  TextView.swift
//  NoteOClock
//
//  Created by Samuel Folledo on 9/17/23.
//

import SwiftUI

struct TextView: View {
    @ObservedObject var card: Card

    @State private var placeHolderText = "Enter text here"
    @FocusState private var isTextEditing: Bool
    private let padding: CGFloat = 4

    var body: some View {
        ZStack {
            let showPlaceholderText = !isTextEditing && card.text.isEmpty
            if showPlaceholderText {
                TextEditor(text: $placeHolderText)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .padding(padding)
                    .background(Color(UIColor.clear))
                    .foregroundColor(Color(uiColor: .gray))
                    .opacity(0.8)
                    .disabled(true)
            }

            TextEditor(text: $card.text)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .padding(padding)
                .background(Color(UIColor.clear))
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

struct TextView_Previews: PreviewProvider {
    static var previews: some View {
        let fakeTextCard = Card(type: .text, origin: .init(x: 80, y: 250), size: .init(width: 200, height: 200), id: "1")
        let fakeTextCard2 = Card(type: .text, origin: .init(x: 250, y: 300), size: .init(width: 150, height: 150), id: "2")

        TextView(card: fakeTextCard)
            .preferredColorScheme(.dark)

        TextView(card: fakeTextCard2)
            .preferredColorScheme(.dark)
    }
}
