//
//  Note.swift
//  StickyBooks
//
//  Created by Zach Eichler on 2021-12-29.
//

import SwiftUI

struct Note: View {
    @State var isBookmarked = false
    var body: some View {
        VStack{
            Divider()
            Text("Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.").padding()
            HStack{
                ZStack{
                    Rectangle().fill(Color("DarkBeige")).frame(width: 40, height: 40).cornerRadius(6).onTapGesture {
                        isBookmarked.toggle()
                    }
                    if(isBookmarked){
                        Image("bookmark_active")
                    }else{
                        Image("bookmark_inactive")
                    }
                }.padding(.trailing,5)
                Text("November 9 - Page 230")
                Spacer()
                Image("options")
                
            }.padding()
            Divider()
        }.frame(maxWidth: .infinity)
    }
}

struct Note_Previews: PreviewProvider {
    static var previews: some View {
        Note()
    }
}
