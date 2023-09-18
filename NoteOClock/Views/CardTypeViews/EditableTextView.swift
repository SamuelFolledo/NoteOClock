//
//  EditableTextView.swift
//  NoteOClock
//
//  Created by Samuel Folledo on 9/17/23.
//

import SwiftUI

struct EditableTextView: View {
    @State private var text = ""
    let placeHolderText = "Enter text here"
    weak var card: Card?

    var body: some View {
        if let card {
            TextField(placeHolderText, text: $text)
                .padding()
                .background(Color(UIColor.systemBackground)) // Set the background color to match the system background color
                .cornerRadius(8) // Optional: You can add a corner radius to round the edges
                .foregroundColor(Color.primary)

                .autocapitalization(.sentences)
                .foregroundColor(card.isSelected ? card.type.textColor : Color(uiColor: .label))
        }
    }
}

struct EditableTextView_Previews: PreviewProvider {
    static var previews: some View {
        EditableTextView()
            .preferredColorScheme(.dark)
    }
}
