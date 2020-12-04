//
//  ContentView.swift
//  Emoji Wid
//
//  Created by Red Phoenix on 04/12/20.
//

import SwiftUI

struct EmojibookListView: View {
    var body: some View {
        NavigationView {
            List {
              ForEach(0..<10, content: { i in
                Text("\(i): 🥳")
                  .font(.largeTitle)
                  .padding([.top, .bottom])
              })
            }
            .foregroundColor(.black)
            .listStyle(InsetGroupedListStyle())
            .navigationBarTitle("Emojibook")
          }
        }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        EmojibookListView()
    }
}
