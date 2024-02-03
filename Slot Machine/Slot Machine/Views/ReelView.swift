//
//  ReelView.swift
//  Slot Machine
//
//  Created by Nicolai Bodean on 29.01.2024.
//

import SwiftUI

struct ReelView: View {
    var body: some View {
        Image("gfx-reel")
            .resizable()
            .modifier(ImageModifier())
    }
}

#Preview {
    ReelView()
}
