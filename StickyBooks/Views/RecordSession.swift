//
//  RecordSession.swift
//  StickyBooks
//
//  Created by Zach Eichler on 2021-12-28.
//

import SwiftUI

struct RecordSession: View {
    @Binding var recordSheet:Bool
    var book:Book
    @Environment(\.managedObjectContext) var moc
    @Environment(\.dismiss) var dismiss
    @State var step = "pageEntry"
    @State private var text = ""
    @State var count = 0
    @FocusState private var noteIsFocused: Bool
    
    
    
    @State var pageNumber = ""
    
    var body: some View {
        NavigationView{
            ZStack{
                Color("BGBeige").edgesIgnoringSafeArea(.all)
                VStack{
                    
                    
                    if(step == "pageEntry"){
                        
                        Text("What page are you on?").font(.title).padding(.top, 100).padding(.bottom, 20)
                        Text("Last Session: \(Int(book.current_page))" )
                        
                        TextField("-", text: $pageNumber)
                            .keyboardType(.decimalPad)
                            .padding()
                            .frame(width: 130, height: 65)
                            .background(Color("DarkBeige"))
                            .cornerRadius(50)
                            .multilineTextAlignment(.center)
                        
                    }else if(step == "summary"){
                        
                        VStack{
                            
                            Text("Write a summary of the last few pages").font(.title).padding(.top, 100).padding(.bottom, 20)
                            
                            TextField("Write a note", text: $text)
                                .padding()
                                .frame(height:55)
                                .background(Color("DarkBeige"))
                            //                            ZStack{
                            //                                Button("Save"){
                            //
                            //                                    count = 1
                            //
                            //                                    if(text != ""){
                            //                                        let newNote = Note(context: moc)
                            //                                        newNote.date = Date.now
                            //                                        newNote.page = Int16((book.current_page))
                            //                                        newNote.text = text
                            //                                        newNote.id = UUID()
                            //                                        newNote.bookTitle = book.title
                            //                                        newNote.isBookmarked = false
                            //                                        noteIsFocused = false
                            //                                        try? moc.save()
                            //                                        text = ""
                            //                                    }
                            //
                            //                                }.foregroundColor(Color("Orange"))
                            //
                            //                            }
                            
                            
                        }
                    }
                    
                    
                    
                    Spacer()
                    Button(action: {
                        
                        if(step == "pageEntry"){
                            
                            if(pageNumber != ""){
                                step = "summary"
                                book.current_page = Double(pageNumber) ?? 0.0
                                try? moc.save()
                            }
                        }else if(step == "summary"){
                            
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
                                dismiss()
                            }else{
                                dismiss()
                            }
                            
                        }
                        
                        
                        
                    }){
                        Text("Save")
                            .frame(maxWidth: .infinity, maxHeight: 50)
                            .background(Color("Orange"))
                            .foregroundColor(.white)
                            .cornerRadius(9)
                            .padding()
                    }
                    
                    
                }
                
                
            }
            .navigationTitle("Record Session")
            .navigationBarTitleDisplayMode(.inline)
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
                
            }
            
        }
        
        
    }
    
}

//struct RecordSession_Previews: PreviewProvider {
//    static var previews: some View {
//        RecordSession()
//    }
//}
