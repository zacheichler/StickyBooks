//
//  ActivityPage.swift
//  StickyBooks
//
//  Created by Zach Eichler on 2021-12-25.
//

import SwiftUI

struct ActivityPage: View {
    @State var recordSheet = false
    @Binding var isPresented:Bool
    var book:Book
    @State var title:String = ""
    
    
    @State private var name: String = "Tim"
    
    var body: some View {
        ZStack{
            Color("BGBeige").edgesIgnoringSafeArea(.all)
            
        VStack(spacing:0){
            ZStack{
                Rectangle().fill(Color("DarkBeige")).frame(height: 41)
                HStack{
                    Text("\(Int(book.pages-book.current_page)) pages left in this book")
                    Spacer()
                    Text("\(Int((book.current_page/book.pages)*100))%")
                }.padding(.trailing, 20).padding(.leading, 20)
                
            }.onAppear(perform: {
                title = "\(book.name.prefix(16))..."
            })
            
            
            ScrollView{
                Note()
                Note()
                Note()
                Note()
                
            }
            
            
            
            

            Spacer()
            HStack(spacing:0){
                TextField("Enter your name", text: $name)
                    .padding()
                    .frame(height:55)
                    .background(Color("DarkBeige"))
                ZStack{
                    Rectangle()
                        .fill(Color("DarkBeige"))
                        .frame(width:55, height:55)
                    Image(systemName: "square.and.pencil")
                    
                }
                
                
            }
            
            
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
                RecordSession()
            }
            .navigationTitle(title)
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                                            Button("Back") {
                                                isPresented.toggle()
                                            }.foregroundColor(Color("Orange"))
                                        }
                    ToolbarItem(placement: .navigationBarTrailing) {
                                            Button("Pause") {
                                                print("Help tapped!")
                                            }.foregroundColor(Color("Orange"))
                                        }
                }
                                
                
        }
    }
    }
}

struct ActivityPage_Previews: PreviewProvider {
    static var previews: some View {
        ActivityPage(isPresented: .constant(true),book:books[0])
    }
}
