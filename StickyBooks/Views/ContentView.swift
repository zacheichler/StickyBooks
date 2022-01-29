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
                    HStack{
                        Spacer()
                        Image("home").resizable().frame(width: 24, height: 24).opacity((current == "Dashboard" ? 1.0 : 0.6))
                        Spacer()
                    }.onTapGesture {
                        let impactMed = UIImpactFeedbackGenerator(style: .medium)
                        impactMed.impactOccurred()
                        current = "Dashboard"
                    }
                    HStack{
                        Spacer()
                        Image("library").resizable().frame(width: 24, height: 24).opacity((current == "Library" ? 1.0 : 0.6))
                        Spacer()
                    }.onTapGesture {
                        let impactMed = UIImpactFeedbackGenerator(style: .medium)
                        impactMed.impactOccurred()
                        current = "Library"
                    }
                    HStack{
                        Spacer()
                        Image("bookmark").resizable().frame(width: 24, height: 24).opacity((current == "Bookmarks" ? 1.0 : 0.6))
                        Spacer()
                    }.onTapGesture {
                        let impactMed = UIImpactFeedbackGenerator(style: .medium)
                        impactMed.impactOccurred()
                        current = "Bookmarks"
                    }
                    HStack{
                        Spacer()
                        Image("user").resizable().frame(width: 24, height: 24).opacity((current == "Profile" ? 1.0 : 0.6))
                        Spacer()
                    }.onTapGesture {
                        let impactMed = UIImpactFeedbackGenerator(style: .medium)
                        impactMed.impactOccurred()
                        current = "Profile"
                    }
                
                }.padding(EdgeInsets(top: 24, leading: 5, bottom: 20, trailing: 5))
            }
        }.background(Color("BGBeige"))
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
            ContentView()
    }
}
