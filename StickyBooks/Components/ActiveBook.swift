//
//  ActiveBook.swift
//  StickyBooks
//
//  Created by Zach Eichler on 2021-12-24.
//

import SwiftUI
import Lottie

struct ActiveBook: View {
    
    @ObservedObject var book: Book
    
    var body: some View {
        
        
        ZStack {
            Rectangle()
                .fill(Color("MedBeige"))
                .frame(height: 141)
                .cornerRadius(10)
            HStack{
                
                if let imgData = book.thumbnail {
                    Image(uiImage: UIImage(data: imgData)!)
                        .resizable()
                        .frame(width: 74, height: 109)
                        .cornerRadius(5)
                        .padding(.leading, 16)
                        .padding(.trailing, 16)
                    
                } else {
                    ZStack(alignment: .top) {
                        Rectangle()
                            .foregroundColor(.accentColor)
                            .opacity(0.8)
                        Text(book.title ?? "Unknown title")
                            .foregroundColor(.white)
                            .font(.headline)
                            .padding()
                    }
                }
                
                VStack(alignment: .leading){
                    
                    Text(book.title ?? "Unknown title").foregroundColor(.black).padding(.bottom, 2)
                    Text(book.author ?? "Unknown title").foregroundColor(.gray).font(.system(size: 12, weight: .regular)).padding(.bottom, 5)
                    VStack{
                        ZStack(alignment: .leading){
                            Rectangle().fill(Color("DarkBeige")).frame(width: 220, height: 5)
                            Rectangle().fill(Color("Orange")).frame(width: 50, height: 5)
                        }
                        HStack{
                            Spacer()
                            if(book.pages != 0){
                                Text(String("\(Int((book.current_page/book.pages)*100))% coomplete")).foregroundColor(.gray).font(.system(size: 10, weight: .regular))
                            }
                        }
                        
                    }.frame(width: 220)
                    
                    
                    
                }
                
                Spacer()
            }
        }
//        ZStack{
//
//            Rectangle()
//                .fill(Color("MedBeige"))
//                .frame(height: 141)
//                .cornerRadius(10)
//
//            if let imgData = book.thumbnail {
//                Image(uiImage: UIImage(data: imgData)!)
//                    .resizable()
//                    .frame(width: 98, height: 145)
//                    .cornerRadius(5)
//            } else {
//                ZStack(alignment: .top) {
//                    Rectangle()
//                        .foregroundColor(.accentColor)
//                        .opacity(0.8)
//                    Text(book.title ?? "Unknown title")
//                        .foregroundColor(.white)
//                        .font(.headline)
//                        .padding()
//                }
//            }
//
//
//            VStack{
//                Spacer()
//                HStack{
//                    Spacer()
//                    ZStack{
//                        Rectangle().fill(Color("Orange")).frame(width: 50, height: 30, alignment: .center).cornerRadius(100)
//                        if(book.pages != 0){
//                            Text(String("\(Int((book.current_page/book.pages)*100))%")).foregroundColor(Color.white)
//                        }
//                    }
//                }.padding(.bottom, 16).padding(.trailing, 16)
//            }
//        }.frame(height: 190)
    }
}

//struct ActiveBook_Previews: PreviewProvider {
//    static var previews: some View {
//        ActiveBook(book: books[0])
//    }
//}
