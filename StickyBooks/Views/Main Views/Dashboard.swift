//
//  Dashboard.swift
//  StickyBooks
//
//  Created by Zach Eichler on 2021-12-24.
//

import SwiftUI

struct Dashboard: View {
    @Binding var showingTabBar:Bool
    @State private var isPresented = false
    //@State var theBook:Book
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: []) var books: FetchedResults<Book>
    
    let layout = [
            GridItem(.adaptive(minimum: 150))
        ]
    
    var body: some View {
        NavigationView{
            
            ZStack{
                Color("BGBeige").edgesIgnoringSafeArea(.all)
                
                VStack(alignment: .leading){
                    
                    Text("Actively Reading").padding(.leading, 7)
                
                    ScrollView{
                        LazyVGrid(columns: layout){
                            
                
                            
                            ForEach(books) { book in
                                
                                if(book.the_status == "Active"){
                                    
                                    NavigationLink {
                                        ActivityPage(book: book)
                                    } label: {
                                        ActiveBook(book:book).padding(7)
                                    }.simultaneousGesture(TapGesture().onEnded{
                                        showingTabBar = false
                                    })
                                    
                                }
                            
                                
                            }
                            
                            
                        }
                }
                    
                    
                    
                    
                }.padding(.trailing, 8).padding(.leading, 8).onAppear(perform: {showingTabBar = true})
        
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

//struct Dashboard_Previews: PreviewProvider {
//    static var previews: some View {
//        Dashboard(theBook: books[0])
//    }
//}
