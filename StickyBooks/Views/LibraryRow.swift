//
//  LibraryRow.swift
//  StickyBooks
//
//  Created by Zach Eichler on 2021-12-17.
//

import SwiftUI

struct LibraryRow: View {
    
    var book: Book
    
    var body: some View {
        
        
        VStack {
            HStack {
                ZStack{
                    
                    Rectangle()
                        .fill(Color("DarkBeige"))
                        .frame(width: 70, height: 70)
                        
                        .cornerRadius(6)
                    book.image.resizable().frame(width: 32, height: 50).cornerRadius(1)
                }
                VStack(alignment: .leading, spacing: 2){
                    Text(book.name).font(.system(size: 18, weight: .bold)).padding(.bottom, 1).padding(.trailing, 10).foregroundColor(.black).multilineTextAlignment(.leading)
                    Text(book.author).font(.system(size: 14, weight: .regular)).foregroundColor(.black)
                    
                }.padding(.leading, 10).lineLimit(2)
                Spacer()
                ZStack{
                    if(book.the_status == "active"){
                        Text("\(Int((book.current_page/book.pages)*100))%").foregroundColor(.black)
                    }else if(book.the_status == "finished"){
                        Circle().fill(Color("Orange")).frame(width:25, height: 25)
                        
                    }else if(book.the_status == "paused"){
                        Text("\(Int((book.current_page/book.pages)*100))%").opacity(0.3).foregroundColor(.black)
                        
                    }else if(book.the_status == "not_started"){
                        Text("0%").opacity(0.3).foregroundColor(.black)
                    }
                }
               
                
            }.padding(EdgeInsets(top:10,leading:20,bottom:10,trailing:20))
        }.background(Color("BGBeige"))
    }
    
    
}



struct LibraryRow_Previews: PreviewProvider {
    static var previews: some View {
        Group{
            LibraryRow(book: books[0])
            LibraryRow(book: books[1])
            LibraryRow(book: books[2])
            LibraryRow(book: books[3])
        }
            
        
        
    }
}
