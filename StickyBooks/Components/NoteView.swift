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
        
        ZStack{
            Color("MedBeige")
            VStack(spacing: 0){
                
                
                
                
                Text("\(note.text ?? "Unknown Text")").padding(EdgeInsets(top: 20, leading: 20, bottom: 10, trailing: 20)).frame(maxWidth: .infinity, alignment: .leading)
                Rectangle().fill(Color("DarkBeige")).frame(maxWidth: .infinity, maxHeight: 0.5)
                HStack{
                    Image("options")
                    Text("Page \(note.page )")
                    Spacer()
                    ZStack{
                        Rectangle().fill(Color("DarkBeige")).frame(width: 50, height: 50).cornerRadius(6).onTapGesture {
                            let impactMed = UIImpactFeedbackGenerator(style: .medium)
                            impactMed.impactOccurred()
                            isBoomarked.toggle()
                            note.isBookmarked.toggle()
                            try? moc.save()
                            
                        }
                        if(isBoomarked){
                            Image("bookmark_active")
                        }else{
                            Image("bookmark_inactive")
                        }
                    }
                    
                    
                    
                    
                }.padding(20)
            }
        }.clipShape(RoundedRectangle(cornerRadius: 10)).frame(maxWidth: .infinity).padding(.leading, 20).padding(.trailing, 20).padding(.top, 15)
                                                                                                                
        
        
    }
}

//struct Note_Previews: PreviewProvider {
//    static var previews: some View {
//        NoteView()
//    }
//}
