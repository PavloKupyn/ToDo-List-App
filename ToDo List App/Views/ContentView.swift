//
//  ContentView.swift
//  ToDo List App
//
//  Created by Eric Cartman on 06.07.2022.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        TasksListView()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(CoreDataTaskListVM())
    }
}

extension Text {
    func blackStyle() -> some View {
        self
        
        .font(.largeTitle)
        .fontWeight(.heavy)
        .foregroundColor(Color.black)
    }
}
extension Text {
    func gradientStyle() -> some View {
        self
        
        .font(.title3)
        .fontWeight(.semibold)
        .foregroundStyle(LinearGradient(gradient: Gradient(colors: [.blue, .secondary]), startPoint: .bottomLeading, endPoint: .topTrailing))
    }
}

struct GrowingButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .scaleEffect(configuration.isPressed ? 1.5 : 1)
            .animation(.easeInOut, value: configuration.isPressed)
    }
}
