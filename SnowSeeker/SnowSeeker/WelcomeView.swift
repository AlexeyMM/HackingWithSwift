//
//  WelcomeView.swift
//  SnowSeeker
//
//  Created by Alexey Morozov on 21.03.2022.
//

import SwiftUI

struct WelcomeView: View {
    var body: some View {
            VStack {
                Text("Welcome to SnowSeeker!")
                    .font(.largeTitle)

                Text("Please select a resort from the left-hand menu; swipe from the left edge to show it.")
                    .foregroundColor(.secondary)
            }
        }
}
