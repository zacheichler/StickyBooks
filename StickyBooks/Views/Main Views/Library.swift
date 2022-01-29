//
//  LibraryList.swift
//  StickyBooks
//
//  Created by Zach Eichler on 2021-12-17.
//

import SwiftUI

struct Library: View {
    let data = BookData()
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
                    
                
                
                  
                    //ScrollView {
                        List{
                            ForEach(books) { book in
                                
                                
                            
                                
                                
                                
                                ZStack {
                                    NavigationLink(destination:
                                                    //useRedText ? .red : .blue
                                                    BookView(book: book,showingTabBar: $showingTabBar)
                                                    
                                    ) {
                                        EmptyView()
                                    }
                                    .opacity(0.0)
                                    .buttonStyle(PlainButtonStyle())


                                    VStack{
                                        LibraryRow(book: book).padding(.top, 5)
                                        Divider()
                                    }
                                    

                                }
                                .listRowInsets(EdgeInsets())
                                .listRowSeparator(.hidden)
                                
                                
                                
                            }.onDelete(perform: deleteBooks)
                                .listRowBackground(Color.clear)
                                
                        }
                        .background(Color("BGBeige"))
                        .listStyle(.plain)
                        .searchable(text: $searchText)
                        .onAppear(perform: {showingTabBar = true})
                        
                    
                        
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
                AddBook(viewModel: data)
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
