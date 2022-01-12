//
//  ActivityPage.swift
//  StickyBooks
//
//  Created by Zach Eichler on 2021-12-25.
//

import SwiftUI

struct ActivityPage: View {
    @State var recordSheet = false
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: []) var notes: FetchedResults<Note>
    
    //@Binding var isPresented:Bool
    var book:Book
    @State var title:String = ""
    @FocusState private var noteIsFocused: Bool
    
    @State private var text = ""

    var body: some View {
        ZStack{
            Color("BGBeige").edgesIgnoringSafeArea(.all)
            
            VStack(spacing:0){
                ZStack{
                    Rectangle().fill(Color("DarkBeige")).frame(height: 41)
                    HStack{
                        Text("\(Int(book.pages-book.current_page)) pages left in this book")
                        Spacer()
                        if(book.pages != 0){
                            Text("\(Int((book.current_page/book.pages)*100))%")
                        }
                    }.padding(.trailing, 20).padding(.leading, 20)
                    
                }.onAppear(perform: {
                    title = "\(book.title ?? "Unknown Title")..."
                })
                
                
                ScrollView{
                    VStack(spacing:0){
                        ForEach(notes){ note in
                            
                            if(note.bookTitle == book.title){
                                NoteView(note: note, isBoomarked: note.isBookmarked)
                            }
                            
                        }
                    }
                    
                    
                }
                
                Spacer()
                HStack(spacing:0){
                    TextField("Write a note", text: $text)
                        .padding()
                        .frame(height:55)
                        .background(Color("DarkBeige"))
                        .focused($noteIsFocused)
                    ZStack{
                        Button("Save"){
                            
                            if(text != ""){
                                let newNote = Note(context: moc)
                                newNote.date = Date.now
                                newNote.page = Int16((book.current_page))
                                newNote.text = text
                                newNote.id = UUID()
                                newNote.bookTitle = book.title
                                newNote.isBookmarked = false
                                noteIsFocused = false
                                try? moc.save()
                                text = ""
                            }
                            
                        }.foregroundColor(Color("Orange"))
                        
                    }
                }.background(Color("DarkBeige"))
                
                if(!noteIsFocused){
                    Button(action: {
                        recordSheet.toggle()
                    }){
                        Text("Record Reading Session")
                            .frame(maxWidth: .infinity, maxHeight: 50)
                            .background(Color("Orange"))
                            .foregroundColor(.white)
                            .cornerRadius(9)
                            .padding()
                    }.sheet(isPresented: $recordSheet){
                        RecordSession(book: book)
                    }
                }
                
            }.onAppear(perform: {noteIsFocused = false})
        }.navigationTitle(title)
            .navigationBarTitleDisplayMode(.inline)
        
    }
    
    
    
}

//struct ActivityPage_Previews: PreviewProvider {
//    static var previews: some View {
//        ActivityPage(isPresented: .constant(true),book:books[0])
//    }
//}
