//
//  ActivityPage.swift
//  StickyBooks
//
//  Created by Zach Eichler on 2021-12-25.
//

import SwiftUI

struct ActivityPage: View {
    @Environment(\.dismiss) var dismiss
    @State var recordSheet = false
    @State var noteSheet = false
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: []) var notes: FetchedResults<Note>
    @State var theTitle = ""
    @State var count = 0
    @State private var showingDoneAlert = false

    
    //@Binding var isPresented:Bool
    var book:Book
    @State var title:String = ""
    @FocusState private var noteIsFocused: Bool
    
    @State private var text = ""
    
    var body: some View {
        ZStack{
            Color("BGBeige").edgesIgnoringSafeArea(.all)
            
        VStack(spacing:0){
                Text("Page \(Int(book.current_page)) of \(Int(book.pages))").foregroundColor(.gray).italic().padding(.bottom, 22)
                ZStack(alignment: .leading){
                    Rectangle().fill(Color("DarkBeige")).frame(maxWidth: .infinity, maxHeight: 5, alignment: .center)
                    Rectangle().fill(Color("Orange")).frame(width: 120, height: 5)
                    //Rectangle().fill(Color("Orange")).frame(width: CGFloat(Int(UIScreen.main.bounds.width * (book.current_page/book.pages))), height: 5)
                }
                .onAppear(perform: {

                    notes.forEach {note in
                        
                        if(note.bookTitle == book.title){
                            count += 1
                        }
                        
                    }
                    
                    
                   
                    
                    theTitle = "\((book.title ?? "Unknown Title").prefix(15))..."
                })
                
                
                if(count == 0){
                    VStack{
                        Spacer()
                        Text("Add your first note, or record a reading session")
                        Spacer()
                    }
                }else{
                    ScrollView{
                        VStack(spacing: 0){
                            
                            
                            
                            ForEach(notes){ note in
                                
                                if(note.bookTitle == book.title){
                                    NoteView(note: note, isBoomarked: note.isBookmarked)
                                }
                                
                            }
                        }
                        
                        
                    }
                    
                }
                
                
                
               
                HStack(spacing:0){
                    TextField("Write a note", text: $text)
                        .padding()
                        .frame(height:55)
                        .background(Color("DarkBeige"))
                    ZStack{
                        Button("Save"){

                            count = 1

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
                    .onTapGesture {
                        noteSheet.toggle()
                    }
                ZStack{
                    
                    Color("BGBeige").edgesIgnoringSafeArea(.all)
                    
                    Button(action: {
                        let impactMed = UIImpactFeedbackGenerator(style: .medium)
                        impactMed.impactOccurred()
                        recordSheet.toggle()
                    }){
                        Text("Record Reading Session")
                            .frame(maxWidth: .infinity, maxHeight: 50)
                            .background(Color("Orange"))
                            .foregroundColor(.white)
                            .cornerRadius(9)
                            .padding()
                            
                    }.sheet(isPresented: $recordSheet){
                        RecordSession(recordSheet: $recordSheet, book: book)
                    }
                    
                }.frame(width: .infinity, height: 100)
        
                
                    
                
                
            }
            .onAppear(perform: {noteIsFocused = false})
            .padding(.top, 15)
        }
        .navigationTitle(theTitle)
        .navigationBarBackButtonHidden(true)
        .navigationBarTitleDisplayMode(.inline)
        .alert("Are you done the book?", isPresented: $showingDoneAlert){
            Button("I'm Done!", role: .none, action: markAsDone)
            Button("Cancel", role: .cancel){}
        }
        .toolbar{
            ToolbarItem(placement: .navigationBarLeading){
                Image("back")
                    .resizable()
                    .frame(width: 40, height: 40)
                    .onTapGesture {
                        let impactMed = UIImpactFeedbackGenerator(style: .medium)
                        impactMed.impactOccurred()
                        dismiss()
                }
                
            }
            ToolbarItem(placement: .navigationBarTrailing){
                Image("tick")
                    .resizable()
                    .frame(width:40, height: 40)
                    .onTapGesture {
                        showingDoneAlert.toggle()
                        let impactMed = UIImpactFeedbackGenerator(style: .medium)
                        impactMed.impactOccurred()
                    }
                
            }
            
        }
        
    }
    
    func markAsDone(){
        
        book.the_status = "Finished"
        try? moc.save()
        
    }
    
    
}

//struct ActivityPage_Previews: PreviewProvider {
//    static var previews: some View {
//        ActivityPage(book:Book())
//    }
//}
