//
//  ContentView.swift
//  Playground
//
//  Created by Loomis Koo on 2023/3/3.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        VStack {
            ScrollViewReader(){proxin in
                ScrollView{
                    
                }
            }
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
