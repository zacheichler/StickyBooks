//
//  LibraryDetail.swift
//  StickyBooks
//
//  Created by Zach Eichler on 2021-12-17.
//

import SwiftUI

struct BookView: View {
    
    @State var isSummary = true
    @Environment(\.dismiss) var dismiss
    var book:Book
    @Binding var showingTabBar:Bool
    @FetchRequest(sortDescriptors: []) var notes: FetchedResults<Note>
    @Environment(\.managedObjectContext) var moc
    @State var theTitle = ""
    
    var body: some View {
        
        ZStack{
        Color("BGBeige").edgesIgnoringSafeArea(.all)
            
        VStack(spacing:0){
            
            HStack(spacing:0){
                VStack{
                    Text("Summary")
                    Rectangle().frame(width: .infinity, height: 6).foregroundColor(isSummary ? Color("Orange") : Color("BGBeige"))
                }.onTapGesture {
                    isSummary = true
                }.onAppear(perform: {
                    
                    showingTabBar = false
                    theTitle = "\((book.title ?? "Unknown Title").prefix(15))..."
                    
                })
                VStack{
                    Text("All Notes")
                    Rectangle().frame(width: .infinity, height: 6).foregroundColor(isSummary ? Color("BGBeige") : Color("Orange"))
                }.onTapGesture {
                    isSummary = false
                }
            }.padding(.top, 20)
            Divider()
            
            ScrollView{
                VStack{
         
                    if isSummary {
                        
                        Summary(book:book)
                        
                    } else {
                        ScrollView{
                            VStack(spacing:0){
                                ForEach(notes){ note in
                                    
                                    if(note.bookTitle == book.title){
                                        NoteView(note: note, isBoomarked: note.isBookmarked)
                                    }
                                    
                                }
                            }
                            
                            
                        }
                    }
                    
                }
            }
            
            

            Spacer()
            
            HStack{
                
                //Active Book
                if(book.the_status == "Active"){
                    Button(action: {
                        book.the_status = "Paused"
                        try? moc.save()
                        
                    }){
                        Text("Pause Book")
                            .frame(maxWidth: .infinity, maxHeight: 50)
                            .foregroundColor(Color("Orange"))
                            .border(Color("Orange"), width: 2, cornerRadius: 9)
                            .padding(EdgeInsets(top: 15, leading: 20, bottom: 20, trailing: 6))
                            
                    }
                    Button(action: {
                        book.the_status = "Finished"
                        try? moc.save()
                        
                    }){
                        Text("Finish Book")
                            .frame(maxWidth: .infinity, maxHeight: 50)
                            .background(Color("Orange"))
                            .foregroundColor(.white)
                            .cornerRadius(9)
                            .padding(EdgeInsets(top: 15, leading: 6, bottom: 20, trailing: 20))
                    }
                //Paused
                }else if(book.the_status == "Paused"){
                    Button(action: {
                        book.the_status = "Active"
                        try? moc.save()
                        
                    }){
                        Text("Resume Reading")
                            .frame(maxWidth: .infinity, maxHeight: 50)
                            .background(Color("Orange"))
                            .foregroundColor(.white)
                            .cornerRadius(9)
                            .padding()
                            
                    }
                  //Finsihed
                }else if(book.the_status == "Finished"){
                    Button(action: {
                        book.the_status = "Active"
                        book.current_page = 0
                        try? moc.save()
                        
                    }){
                        Text("Read Again")
                            .frame(maxWidth: .infinity, maxHeight: 50)
                            .background(Color("Orange"))
                            .foregroundColor(.white)
                            .cornerRadius(9)
                            .padding()
                            
                    }
                    
                   //Not Started
                }else if(book.the_status == "Not Started"){
                    Button(action: {
                        book.the_status = "Active"
                        book.current_page = 0
                        try? moc.save()
                        
                    }){
                        Text("Start Book")
                            .frame(maxWidth: .infinity, maxHeight: 50)
                            .background(Color("Orange"))
                            .foregroundColor(.white)
                            .cornerRadius(9)
                            .padding()
                            
                    }
                   
                }
            }
            
            
            .navigationTitle(theTitle)
                .navigationBarTitleDisplayMode(.inline)
                .accentColor(Color("Orange"))
                .navigationBarBackButtonHidden(true)
                
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
}




//struct BookView_Previews: PreviewProvider {
//    static var previews: some View {
//        BookView(book:books[0])
//    }
//}
