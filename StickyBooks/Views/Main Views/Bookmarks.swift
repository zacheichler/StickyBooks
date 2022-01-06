//
//  Bookmarks.swift
//  StickyBooks
//
//  Created by Zach Eichler on 2021-12-24.
//

import SwiftUI

struct Bookmarks: View {
    var body: some View {
        NavigationView{
            
            ZStack{
                Color("BGBeige").edgesIgnoringSafeArea(.all)
                
                ScrollView(){
                    Note()
                    Note()
                    Note()
                    Note()
                    Note()
                    Note()
                    Note()
                    Note()
                }
               
                
                .navigationTitle("Bookmarks")
                
            }
            
            
            
        }
    }
}

struct Bookmarks_Previews: PreviewProvider {
    static var previews: some View {
        Bookmarks()
    }
}
