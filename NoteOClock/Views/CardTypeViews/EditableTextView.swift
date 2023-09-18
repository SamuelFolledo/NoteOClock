//
//  EditableTextView.swift
//  NoteOClock
//
//  Created by Samuel Folledo on 9/17/23.
//

import SwiftUI

struct EditableTextView: View {
    let placeHolderText = "Enter text here"
    var card: Card

    var body: some View {
        //            TextField(placeHolderText, text: $text)
        Text(card.type.title)
            .padding()
        //                .background(Color(UIColor.systemBackground))
        //                .cornerRadius(8)
        //                .autocapitalization(.sentences)
            .foregroundColor(card.isSelected ? card.type.textColor : Color(uiColor: .label))
    }
}

struct EditableTextView_Previews: PreviewProvider {
    static var previews: some View {
        EditableTextView(card: fakeTextCard)
            .preferredColorScheme(.dark)
    }
}
