//
//  Checkmark animation.swift
//  ToDo List App
//
//  Created by Eric Cartman on 17.08.2022.
//

import SwiftUI

struct CheckmarkAnimation: View {
    @State private var isAnimating = false
    @State private var color = Color.green
    
    var body: some View {
        ZStack {
            Circle()
                .trim(to: isAnimating ? 1:0)
                .stroke(color, lineWidth: 3)
                .frame(width: 100, height: 100)
                .animation(.easeInOut(duration: 1), value: isAnimating)
            
            Image(systemName: "checkmark")
                .foregroundColor(color)
                .font(.largeTitle)
                .scaleEffect(isAnimating ? 1.5 : 0)
                .animation(.spring(response: 0.5, dampingFraction: 0.4).delay(1), value: isAnimating)
                
        }
        .scaleEffect(isAnimating ? 0 : 1)
        .animation(.linear(duration: 0.01).delay(2), value: isAnimating)
        .onAppear {
            isAnimating.toggle()
        }
    }
}

struct CheckmarkAnimation_Previews: PreviewProvider {
    static var previews: some View {
        CheckmarkAnimation()
    }
}
