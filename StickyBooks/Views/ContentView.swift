//
//  ContentView.swift
//  StickyBooks
//
//  Created by Zach Eichler on 2021-12-02.
//

import SwiftUI

struct ContentView: View {
    @State var showingTabBar = true
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: []) var books: FetchedResults<Book>
    @FetchRequest(sortDescriptors: []) var notes: FetchedResults<Note>
    
    
    
    
    @State var current = "Dashboard"
    
    var body: some View {
        VStack(spacing:0){
            
            if(current == "Dashboard"){
                Dashboard(showingTabBar: $showingTabBar).onAppear {
                    showingTabBar = true
                }
            }else if(current == "Library"){
                Library(showingTabBar: $showingTabBar).onAppear {
                    showingTabBar = true
                }
            }else if(current == "Bookmarks"){
                Bookmarks().onAppear {
                    showingTabBar = true
                }
            }else{
                Profile().onAppear {
                    showingTabBar = true
                }
            }
            
            
            
            if(showingTabBar){
                Rectangle().fill(Color.gray).frame(maxWidth: .infinity, maxHeight: 0.5)
                HStack{
                    Image("home").resizable().frame(width: 24, height: 24).onTapGesture {
                        current = "Dashboard"
                    }.opacity((current == "Dashboard" ? 1.0 : 0.6))
                    Spacer()
                    Image("library").resizable().frame(width: 24, height: 24).onTapGesture {
                        current = "Library"
                    }.opacity((current == "Library" ? 1.0 : 0.6))
                    Spacer()
                    Image("bookmark").resizable().frame(width: 24, height: 24).onTapGesture {
                        current = "Bookmarks"
                    }.opacity((current == "Bookmarks" ? 1.0 : 0.6))
                    Spacer()
                    Image("user").resizable().frame(width: 24, height: 24).onTapGesture {
                        current = "Profile"
                    }.opacity((current == "Profile" ? 1.0 : 0.6))
                }.padding(EdgeInsets(top: 24, leading: 50, bottom: 20, trailing: 50))
            }
        }.background(Color("BGBeige"))
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
            ContentView()
    }
}
