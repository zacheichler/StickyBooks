//
//  LibraryDetail.swift
//  StickyBooks
//
//  Created by Zach Eichler on 2021-12-17.
//

import SwiftUI

struct BookView: View {
    
    @State var isSummary = true
    
    var book:Book
    
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
                }
                VStack{
                    Text("Notes")
                    Rectangle().frame(width: .infinity, height: 6).foregroundColor(isSummary ? Color("BGBeige") : Color("Orange"))
                }.onTapGesture {
                    isSummary = false
                }
            }
            Divider()
            
            VStack{
     
                if isSummary {
                    Summary(book:book)
                    
                } else {
                    /*@START_MENU_TOKEN@*/EmptyView()/*@END_MENU_TOKEN@*/
                }
                
            }
            
            

            Spacer()
                .navigationTitle(book.name)
                .navigationBarTitleDisplayMode(.inline)
        }
    }
    }
}




struct BookView_Previews: PreviewProvider {
    static var previews: some View {
        BookView(book:books[0])
    }
}
