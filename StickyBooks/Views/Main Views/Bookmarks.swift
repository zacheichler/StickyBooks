//
//  Bookmarks.swift
//  StickyBooks
//
//  Created by Zach Eichler on 2021-12-24.
//

import SwiftUI

struct Bookmarks: View {
    
    @FetchRequest(sortDescriptors: []) var notes: FetchedResults<Note>
    
    var body: some View {
        NavigationView{
            
            ZStack{
                Color("BGBeige").edgesIgnoringSafeArea(.all)
                
                ScrollView(){
                    
                    
                    VStack(spacing:0){
                        
                       
                        
                        ForEach(notes){ note in
                            
                            if(note.isBookmarked){
                                NoteView(note: note, isBoomarked: note.isBookmarked)
                            }
                            
                            
                            
                        }
                    }
                    
                    
                }
                
            }
            
            
            .navigationTitle("Bookmarks")
            
        }
        
        
        
    }
}


//struct Bookmarks_Previews: PreviewProvider {
//    static var previews: some View {
//        Bookmarks()
//    }
//}
