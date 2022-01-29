//
//  tempAddList.swift
//  StickyBooks
//
//  Created by Zach Eichler on 2022-01-12.
//

import SwiftUI
import SwiftUIX

struct AddBook: View {
    @ObservedObject var viewModel: BookData
    @State private var searchingText: String = ""
    @State var isEditing: Bool = false
    
    var body: some View {
        NavigationView {
            
            
            
            ZStack {
                
                Color("BGBeige").edgesIgnoringSafeArea(.all)
                VStack(spacing: 0) {
                    SearchBar("Search...", text: $searchingText, isEditing: $isEditing)
                        .showsCancelButton(isEditing)
                        .onCancel { searchingText = "" }
                
                    
                    List {
                        ForEach(viewModel.books) { book in
                            
                            CellView(for: book)
                                .listRowBackground(Color("BGBeige"))
                                //.listRowInsets(EdgeInsets())
                                //.listRowSeparator(.hidden)
                            
//                            ZStack{
//                                Color("BGBeige").edgesIgnoringSafeArea(.all)
//                                CellView(for: book)
//                                    .listRowBackground(Color("BGBeige"))
//                                    .listRowInsets(EdgeInsets())
//                                    .listRowSeparator(.hidden)
//                            }.frame(maxWidth: .infinity)
                            

                        }
                    }
                    .navigationTitle(Text("Search for Books"))
                    .navigationBarTitleDisplayMode(.inline)
                    .listStyle(PlainListStyle())
                    .onAppear { !searchingText.isEmpty ? viewModel.getBooks(containing: searchingText) : viewModel.getBooks() }
                    .onChange(of: searchingText) { _ in
                        !searchingText.isEmpty ? viewModel.getBooks(containing: searchingText) : viewModel.getBooks()
                    }
                }
            }
        }
    }
}
