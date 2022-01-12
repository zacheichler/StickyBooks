//
//  Note.swift
//  StickyBooks
//
//  Created by Zach Eichler on 2021-12-29.
//

import SwiftUI

struct NoteView: View {
    
    
    var note: Note
    @Environment(\.managedObjectContext) var moc
    @State var isBoomarked:Bool
    var body: some View {
        VStack(spacing: 0){
            Rectangle().fill(Color("DarkBeige")).frame(maxWidth: .infinity, maxHeight: 0.5)
            Text("\(note.text ?? "Unknown Text")").padding(EdgeInsets(top: 20, leading: 20, bottom: 5, trailing: 20)).frame(maxWidth: .infinity, alignment: .leading)
            HStack{
                ZStack{
                    Rectangle().fill(Color("DarkBeige")).frame(width: 40, height: 40).cornerRadius(6).onTapGesture {
                        isBoomarked.toggle()
                        note.isBookmarked.toggle()
                        try? moc.save()
                        
                    }
                    if(isBoomarked){
                        Image("bookmark_active")
                    }else{
                        Image("bookmark_inactive")
                    }
                }.padding(.trailing,5)
                Text("November 9 • Page \(note.page )")
                Spacer()
                Image("options")
                
            }.padding(20)
        }.frame(maxWidth: .infinity)
    }
}

//struct Note_Previews: PreviewProvider {
//    static var previews: some View {
//        NoteView()
//    }
//}
