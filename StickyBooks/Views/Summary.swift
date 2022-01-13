//
//  Summary.swift
//  StickyBooks
//
//  Created by Zach Eichler on 2021-12-21.
//

import SwiftUI

struct Summary: View {
    
    @State var book:Book
    
    @Environment(\.managedObjectContext) var moc
    @Environment(\.dismiss) var dismiss
    @State private var showingDeleteAlert = false
    @FetchRequest(sortDescriptors: []) var notes: FetchedResults<Note>
    
    
 
    
    
    
    var body: some View {
        
        
        VStack {
            ZStack{
                Rectangle().fill(Color("DarkBeige")).frame(height:300, alignment: .center)
                
                
                if let imgData = book.thumbnail {
                    Image(uiImage: UIImage(data: imgData)!)
                        .resizable()
                        .frame(width: 136, height: 200)
                        .cornerRadius(5)
                } else {
                    ZStack(alignment: .top) {
                        Rectangle()
                            .foregroundColor(.accentColor)
                            .opacity(0.8)
                        Text(book.title ?? "Unknown title")
                            .foregroundColor(.white)
                            .font(.headline)
                            .padding()
                    }
                }
                
            }
            
            VStack(alignment: .leading){
                
                
                VStack(alignment: .leading){
                    if(book.the_status == "Active"){
                        Text(book.the_status ?? "Unknown Status").textCase(.uppercase).frame(maxWidth: .infinity, alignment: .leading).font(.headline).foregroundColor(Color("Orange")).padding(.bottom, 2)
                    }else if(book.the_status == "Finished"){
                        Text(book.the_status ?? "Unknown Status").textCase(.uppercase).frame(maxWidth: .infinity, alignment: .leading).font(.headline).foregroundColor(Color("Orange")).padding(.bottom, 2)
                        
                    }else if(book.the_status == "Paused"){
                        Text(book.the_status ?? "Unknown Status").textCase(.uppercase).frame(maxWidth: .infinity, alignment: .leading).font(.headline).foregroundColor(Color("Orange")).padding(.bottom, 2)
                        
                    }else if(book.the_status == "Not Started"){
                        Text(book.the_status ?? "Unknown Status").textCase(.uppercase).frame(maxWidth: .infinity, alignment: .leading).font(.headline).foregroundColor(Color("Orange")).padding(.bottom, 2)
                    }
                    
                    
                    Text(book.title ?? "Unknown Title").font(.title).padding(.bottom, 5)
                    HStack{
                        Text("\(book.author ?? "Unknown Author")")
                            .font(.subheadline)
                        Text("•")
                            .font(.subheadline)
                        Text("\(Int(book.pages)) pages")
                            .font(.subheadline)
                    }.padding(.bottom, 8)
                    
                    if(book.genre != ""){
                        HStack{
                            Text("\(book.genre ?? "Unknown Genre")").padding(EdgeInsets(top:5, leading:10,bottom:5,trailing:10)).background(Color("DarkBeige")).cornerRadius(5)
                        }.padding(.bottom, 30)
                    }
                    
                    
                    Text("Bookmarks").font(.headline)
                }.padding(.leading, 20)
                
                VStack(spacing: 0){
                    ForEach(notes){ note in
                        
                        if(note.bookTitle == book.title && note.isBookmarked == true){
                            NoteView(note: note, isBoomarked: note.isBookmarked)
                        }
                        
                    }
                }
                
            }.padding(.top, 30)
            
            
            
            
            
        }.alert("Delete book?", isPresented: $showingDeleteAlert){
            Button("Delete", role: .destructive, action: deleteBook)
            Button("Cancel", role: .cancel){}
        } message: {
            Text("You will lose all notes associated with this book")
        }.toolbar{
            Button{
                showingDeleteAlert = true
            } label: {
                Label("Delete this book", systemImage: "trash").foregroundColor(Color("Orange"))
            }
        }
            
        
        
        
    }
    func deleteBook(){
        moc.delete(book)
        try? moc.save()
        dismiss()
    }
}

//struct Summary_Previews: PreviewProvider {
//    static var previews: some View {
//        Summary(book:Book())
//    }
//}
