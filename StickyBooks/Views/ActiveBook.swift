//
//  ActiveBook.swift
//  StickyBooks
//
//  Created by Zach Eichler on 2021-12-24.
//

import SwiftUI

struct ActiveBook: View {
    
    var book: Book
    
    var body: some View {
        ZStack{
            
            Rectangle()
                .fill(Color("DarkBeige"))
                .frame(height: 190)
                .cornerRadius(10)
            Image(book.imageName ?? "Unknown")
                .resizable()
                .frame(width: 98, height: 145)
                .cornerRadius(5)

            VStack{
                Spacer()
                HStack{
                    Spacer()
                    ZStack{
                        Rectangle().fill(Color("Orange")).frame(width: 50, height: 30, alignment: .center).cornerRadius(100)
                        if(book.pages != 0){
                            Text(String("\(Int((book.current_page/book.pages)*100))%")).foregroundColor(Color.white)
                        }
                    }
                }.padding(.bottom, 16).padding(.trailing, 16)
            }
        }.frame(height: 190)
    }
}

//struct ActiveBook_Previews: PreviewProvider {
//    static var previews: some View {
//        ActiveBook(book: books[0])
//    }
//}
