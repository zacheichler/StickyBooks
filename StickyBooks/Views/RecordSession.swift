//
//  RecordSession.swift
//  StickyBooks
//
//  Created by Zach Eichler on 2021-12-28.
//

import SwiftUI

struct RecordSession: View {
    var book:Book
    @Environment(\.managedObjectContext) var moc
    @Environment(\.dismiss) var dismiss
    
    
    @State var pageNumber = ""
    
    var body: some View {
        NavigationView{
            ZStack{
                Color("BGBeige").edgesIgnoringSafeArea(.all)
                VStack{
                    Text("What page are you on?").font(.title).padding(.top, 100).padding(.bottom, 20)
                    Text("Last Session: \(Int(book.current_page))" )
                    
                    TextField("-", text: $pageNumber)
                        .keyboardType(.decimalPad)
                        .padding()
                        .frame(width: 130, height: 65)
                        .background(Color("DarkBeige"))
                        .cornerRadius(50)
                        .multilineTextAlignment(.center)
                    Spacer()
                    Button(action: {
                        
                        if(pageNumber != ""){
                            book.current_page = Double(pageNumber) ?? 0.0
                            try? moc.save()
                            dismiss()
                        }
                        
                    }){
                        Text("Save")
                            .frame(maxWidth: .infinity, maxHeight: 50)
                            .background(Color("Orange"))
                            .foregroundColor(.white)
                            .cornerRadius(9)
                            .padding()
                    }
                    
                    
                }
                
    
            }
            .navigationTitle("Record Session")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

//struct RecordSession_Previews: PreviewProvider {
//    static var previews: some View {
//        RecordSession()
//    }
//}
