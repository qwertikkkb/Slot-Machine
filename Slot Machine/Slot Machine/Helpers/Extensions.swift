//
//  Extensions.swift
//  Slot Machine
//
//  Created by Nicolai Bodean on 28.01.2024.
//

import SwiftUI

extension Text {
    func scoreLabelStyle() -> Text {
        self
            .foregroundStyle(.white)
            .font(.system(size: 10, weight: .bold, design: .rounded))
    }
    func scoreNumberStyle () -> Text {
        self
            .foregroundStyle(.white)
            .font(.system(.title, design: .rounded))
            .fontWeight(.heavy)
    }
    
}
