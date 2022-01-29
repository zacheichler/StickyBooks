//
//  AddBookView.swift
//  StickyBooks
//
//  Created by Zach Eichler on 2022-01-06.
//

import SwiftUI

struct SaveBook: View {
    let book: Response.Book
    let bookThumbnail: UIImage?
    
    init(for book: Response.Book, image: UIImage? = nil) {
        self.book = book
        bookThumbnail = image
    }
    
    
    var starting_status = ["Active", "Finished", "Not Started"]
    
    @Environment(\.managedObjectContext) var moc
    @Environment(\.dismiss) var dismiss
    
    @State private var title = ""
    @State private var author = ""
    @State private var current_page = 0
    @State private var genre = ""
    @State private var imageName = ""
    @State private var the_status = "Active"
    @State private var pages = 0
    let genres = ["Fantasy", "Horror", "Kids", "Mystery", "Poetry", "Romance", "Thriller"]
    let status = ["Active", "Finished", "Paused", "Not Started"]
    
    
    
    var body: some View {
        NavigationView{
            
            ZStack{
                Color("BGBeige").edgesIgnoringSafeArea(.all)
                VStack{
                    
                    ThumbnailCover(bookThumbnail: bookThumbnail, width: 95)
                    
                    List{
                        
                        HStack{
                            Text("Title")
                            Spacer()
                            TextField("Name of book", text: $title)
                            
                        }
                        TextField("Author's Name", text: $author)
                        TextField("Number of Pages", value: $pages, formatter: NumberFormatter())
                        TextField("Current Page", value: $current_page, formatter: NumberFormatter())
                            .keyboardType(.decimalPad)
                        Picker("Genre", selection: $genre){
                            ForEach(genres, id: \.self){
                                Text($0)
                            }
                        }
                        
                        Picker("What is your reading status", selection: $the_status) {
                            ForEach(starting_status, id: \.self) {
                                Text($0)
                            }
                        }
                        .pickerStyle(.segmented)
                        
                        

                        
                    }
                    .navigationTitle("Add Book")
                    .onAppear(perform: {
                        title = book.volumeInfo.title
                        author = book.volumeInfo.authors?.joined(separator:", ") ?? "No Author"
                        pages = book.volumeInfo.pageCount ?? 0
                        
                    })
                    
                    Button(action: {
                        let newBook = Book(context: moc)
                        newBook.id = UUID()
                        newBook.title = title
                        newBook.author = author
                        newBook.current_page = Double(current_page)
                        newBook.pages = Double(pages)
                        newBook.thumbnail = bookThumbnail?.pngData()
                        newBook.genre = genre
                        newBook.the_status = the_status
                        
                        
                        try? moc.save()
                        dismiss()
                    }){
                        Text("Record Reading Session")
                            .frame(maxWidth: .infinity, maxHeight: 50)
                            .background(Color("Orange"))
                            .foregroundColor(.white)
                            .cornerRadius(9)
                            .padding()
                    }
                    
                }
            }
        }
    }
}

//struct AddBookView_Previews: PreviewProvider {
//    static var previews: some View {
//        SaveBook()
//    }
//}
