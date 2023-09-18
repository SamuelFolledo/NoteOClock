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

    var body: some View {
        TextField(placeHolderText, text: $text)
            .padding()
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .autocapitalization(.none)
    }
}

struct EditableTextView_Previews: PreviewProvider {
    static var previews: some View {
        EditableTextView()
    }
}
