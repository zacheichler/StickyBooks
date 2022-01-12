//
//  LibraryList.swift
//  StickyBooks
//
//  Created by Zach Eichler on 2021-12-17.
//

import SwiftUI

struct Library: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: [
        SortDescriptor(\.title)
    ]) var books: FetchedResults<Book>
    
    @State var searchText = ""
    @State private var showingAddScreen = false
    @Binding var showingTabBar:Bool
   
    
    
    var body: some View {
        
        NavigationView{
            
            ZStack{
                Color("BGBeige").edgesIgnoringSafeArea(.all)
                
                
                VStack {
                    
                        ZStack {
                            Rectangle()
                                .foregroundColor(Color("DarkBeige"))
                            HStack {
                                Image(systemName: "magnifyingglass")
                                TextField("Search ..", text: $searchText)
                            }
                                .foregroundColor(.gray)
                                .padding(.leading, 13)
                        }
                            .frame(height: 40)
                            .cornerRadius(13)
                            .padding()
                            .onAppear(perform: {showingTabBar = true})
                  
                    //ScrollView {
                        List{
                            ForEach(books) { book in
                                
                                
                            
                                
                                
                                
                                ZStack {
                                    NavigationLink(destination:
                                                    BookView(book: book,showingTabBar: $showingTabBar)
                                    ) {
                                        EmptyView()
                                    }
                                    .opacity(0.0)
                                    .buttonStyle(PlainButtonStyle())



                                    LibraryRow(book: book)

                                }
                                .listRowInsets(EdgeInsets())
                                .listRowSeparator(.hidden)
                                
                                
                                
                            }.onDelete(perform: deleteBooks)
                                .listRowBackground(Color.clear)
                                
                        }
                        .background(Color("BGBeige"))
                        .listStyle(.plain)
                        
                    
                        
                    //}
                    
                }
                
            }
            
            .navigationTitle("Library")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {showingAddScreen.toggle()}) {
                                            Image(systemName: "plus")
                                        }.foregroundColor(Color("Orange"))
                
                }
                
                    
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {showingAddScreen.toggle()}) {
                        EditButton().foregroundColor(Color("Orange"))
                                    }
                }
                
            }.sheet(isPresented: $showingAddScreen){
                AddBookView()
            }
            
        }
        
        
        
    }
    
    func deleteBooks(at offsets: IndexSet){
        for offset in offsets {
            let book = books[offset]
            moc.delete(book)
        }

    }
    
    
}

//struct Library_Previews: PreviewProvider {
//    static var previews: some View {
//        Library()
//    }
//}
