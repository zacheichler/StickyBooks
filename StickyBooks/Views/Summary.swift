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
                Rectangle().fill(Color("MedBeige")).frame(height:300, alignment: .center)
                
                
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
                    
                    Text(book.the_status ?? "Unknown Status").textCase(.uppercase).foregroundColor(Color("Orange")).font(.system(size: 16, weight: .bold)).padding(.bottom, 5)
                    
                    Text(book.title ?? "Unknown Title").foregroundColor(.black).font(.system(size: 24, weight: .medium)).padding(.bottom, 5)
                    
                    Text("\(book.author ?? "Unknown Author") • \(Int(book.pages)) pages").foregroundColor(.gray).font(.system(size: 16, weight: .medium))
                
                    
                }.frame(maxWidth: .infinity, alignment: .leading).padding(.trailing, 20).padding(.leading, 20)
                
                VStack(alignment: .leading, spacing: 0){
                    
                    Text("Saved Notes").foregroundColor(.black).font(.system(size: 18, weight: .medium)).padding(20)
                    
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
            
            Image("trash")
                .resizable()
                .frame(width: 40, height: 40)
                .onTapGesture {
                    showingDeleteAlert = true
                    let impactMed = UIImpactFeedbackGenerator(style: .medium)
                    impactMed.impactOccurred()
                    
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
