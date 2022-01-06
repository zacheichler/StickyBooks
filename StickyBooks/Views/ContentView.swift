//
//  ContentView.swift
//  StickyBooks
//
//  Created by Zach Eichler on 2021-12-02.
//

import SwiftUI

struct ContentView: View {
    
    
    @State var current = "Dashboard"
    
    var body: some View {
        VStack{
            
            if(current == "Dashboard"){
                Dashboard(theBook: books[0])
            }else if(current == "Library"){
                Library()
            }else if(current == "Bookmarks"){
                Bookmarks()
            }else{
                Profile()
            }
            
            Divider()
            
            
            HStack{
                Image("home").resizable().frame(width: 24, height: 24).onTapGesture {
                    current = "Dashboard"
                }
                Spacer()
                Image("library").resizable().frame(width: 24, height: 24).onTapGesture {
                    current = "Library"
                }
                Spacer()
                Image("bookmark").resizable().frame(width: 24, height: 24).onTapGesture {
                    current = "Bookmarks"
                }
                Spacer()
                Image("user").resizable().frame(width: 24, height: 24).onTapGesture {
                    current = "Profile"
                }
            }.padding(EdgeInsets(top: 0, leading: 50, bottom: 20, trailing: 50))

        }.background(Color("BGBeige"))
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
            ContentView()
    }
}
