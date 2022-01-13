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
            VStack{
            
                ThumbnailCover(bookThumbnail: bookThumbnail, width: 95)
                
                Form{
                    Section{
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
                        Picker("Reading Status", selection: $the_status){
                            ForEach(status, id: \.self){
                                Text($0)
                            }
                        }
                    }.onAppear(perform: {
                        title = book.volumeInfo.title
                        author = book.volumeInfo.authors?.joined(separator:", ") ?? "No Author"
        
                    })
                    
                    Section{
                        Button("Save"){
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
                        }
                    }
                }.navigationTitle("Add Book")
        }
        }
    }
}

//struct AddBookView_Previews: PreviewProvider {
//    static var previews: some View {
//        AddBookView()
//    }
//}
