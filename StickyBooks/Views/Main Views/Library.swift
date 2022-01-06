//
//  LibraryList.swift
//  StickyBooks
//
//  Created by Zach Eichler on 2021-12-17.
//

import SwiftUI

struct Library: View {
    
    @State var searchText = ""
    
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
                    ScrollView {
                        VStack(spacing: 0){
                            ForEach(books) { book in
                                
                                NavigationLink{
                                    Divider().padding(.bottom, 5)
                                    BookView(book: book)
                                } label: {
                                    LibraryRow(book: book)
                                        .listRowInsets(EdgeInsets())
                                }
                                
                            }
                        }
                        
                    }
                    
                }
                
            }
            
            .navigationTitle("Library")
            
        }
        
        
        
    }
}

struct Library_Previews: PreviewProvider {
    static var previews: some View {
        Library()
    }
}
