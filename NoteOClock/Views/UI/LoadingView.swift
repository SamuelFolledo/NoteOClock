//
//  LoadingView.swift
//  NoteOClock
//
//  Created by Samuel Folledo on 11/6/23.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {
        ProgressView()
            .progressViewStyle(CircularProgressViewStyle(tint: Color(uiColor: .label)))
            .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview {
    LoadingView()
}
