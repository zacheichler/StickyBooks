//
//  Summary.swift
//  StickyBooks
//
//  Created by Zach Eichler on 2021-12-21.
//

import SwiftUI

struct Summary: View {
    
    var book:Book
    
    
    
    var body: some View {
        
        
        
        VStack {
            ZStack{
                Rectangle().fill(Color("DarkBeige")).frame(height:300, alignment: .center)
                
                book.image.resizable().frame(width: 136, height: 200).cornerRadius(5)
                
            }
            
            VStack(alignment: .leading){
                
                
                
                if(book.the_status == "active"){
                    Text("ACTIVELY READING").frame(maxWidth: .infinity, alignment: .leading).font(.headline).foregroundColor(Color("Orange"))
                }else if(book.the_status == "finished"){
                    Text("FINISHED BOOK").frame(maxWidth: .infinity, alignment: .leading).font(.headline).foregroundColor(Color("Orange"))
                    
                }else if(book.the_status == "paused"){
                    Text("ON PAUSE").frame(maxWidth: .infinity, alignment: .leading).font(.headline).foregroundColor(Color("Orange"))
                    
                }else if(book.the_status == "not_started"){
                    Text("NOT STARTED").frame(maxWidth: .infinity, alignment: .leading).font(.headline).foregroundColor(Color("Orange"))
                }
                
                
                Text(book.name).font(.title)
                Text("\(book.author) • \(Int(book.pages))").font(.subheadline)
                
                HStack{
                    Text("History of Civilization").padding(EdgeInsets(top:5, leading:10,bottom:5,trailing:10)).background(Color("DarkBeige")).cornerRadius(5)
                    Text("Evolution").padding(EdgeInsets(top:5, leading:10,bottom:5,trailing:10)).background(Color("DarkBeige")).cornerRadius(5)
                    
                }
                
            }.padding(.leading, 20).padding(.top, 30)
            
            
            
        }
        
        
        
        
    }
}

struct Summary_Previews: PreviewProvider {
    static var previews: some View {
        Summary(book:books[0])
    }
}
