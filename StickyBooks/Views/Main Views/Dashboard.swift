//
//  Dashboard.swift
//  StickyBooks
//
//  Created by Zach Eichler on 2021-12-24.
//

import SwiftUI

struct Dashboard: View {
    
    @State private var isPresented = false
    @State var theBook:Book
    
    let layout = [
            GridItem(.adaptive(minimum: 150))
        ]
    
    var body: some View {
        NavigationView{
            
            ZStack{
                Color("BGBeige").edgesIgnoringSafeArea(.all)
                
                VStack(alignment: .leading){
                    
                    Text("Actively Reading").padding(.leading, 7)
                
                    LazyVGrid(columns: layout){
                        
                        ForEach(books) {book in
                            if(book.the_status == "active"){
                                ActiveBook(book: book).padding(7).onTapGesture {
                                    theBook = book
                                    isPresented.toggle()
                                    
                                }
                            }
                        }.fullScreenCover(isPresented: $isPresented){
                            NavigationView{
                                VStack{
                                    ActivityPage(isPresented: $isPresented,book: theBook)
                                }
                                
                            }
                        }
                        
                    }
                    
                    Spacer()
                    
                }.padding(.trailing, 8).padding(.leading, 8)
                

                
                
                
                
               
                
                .navigationTitle("Dashboard")
                .toolbar {
                    
                    ToolbarItem(placement: .navigationBarTrailing) {
                        ZStack{
                            Rectangle()
                                .fill(Color("DarkBeige"))
                                .frame(width: 66, height: 40)
                                .cornerRadius(20)
                            HStack{
                                Image("streak")
                                Text("0")
                            }
                        }
                                        }
                }
                
            }
            
            
        }
    }
}

struct Dashboard_Previews: PreviewProvider {
    static var previews: some View {
        Dashboard(theBook: books[0])
    }
}
