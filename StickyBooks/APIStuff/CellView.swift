

import SwiftUI

struct CellView: View {
    let book: Response.Book
    
    init(for book: Response.Book) {
        self.book = book
    }
    
    @State private var bookThumbnail: UIImage?
    
    var body: some View {
        NavigationLink(destination: SaveBook(for: book, image: bookThumbnail)) {
            
            HStack{
                
                ZStack(alignment: .center){
                    
                    Rectangle()
                        .fill(Color("DarkBeige"))
                        .frame(width: 70, height: 70)
                        .cornerRadius(6)
                    ThumbnailCover(bookThumbnail: bookThumbnail).frame(width: 32, height: 46)
                    
                }
                
                VStack{
                    
                    VStack(alignment: .leading, spacing: 2){
                        Text(book.volumeInfo.title).font(.system(size: 18, weight: .bold)).padding(.bottom, 1).padding(.trailing, 10).foregroundColor(.black).multilineTextAlignment(.leading)
                        
                        if let authors = book.volumeInfo.authors {
                            ForEach(authors, id: \.self){ author in
                                Text(author).font(.system(size: 14, weight: .regular)).foregroundColor(.black)
                            }
                        }
                        
                        
                    }.padding(.leading, 10).lineLimit(2)
                    
                }
                
                
            }.background(Color("BGBeige")).padding(.top, 10).padding(.bottom, 10)
            
            
            
//            LazyHStack(alignment: .top) {
//
//                ZStack(alignment: .center){
//
//                    Rectangle()
//                        .fill(Color("DarkBeige"))
//                        .frame(width: 70, height: 70)
//                        .cornerRadius(6)
//                    ThumbnailCover(bookThumbnail: bookThumbnail).frame(width: 32, height: 46)
//
//                }
//
//
//
//
//
//                LazyVStack(alignment: .leading) {
//                    Text(book.volumeInfo.title).font(.headline)
//
//                    if let authors = book.volumeInfo.authors {
//                        ForEach(authors, id: \.self){ author in
//                            Text(author).font(.subheadline)
//                        }
//                    }
//                }
//
//            }.background(Color("BGBeige"))
            
            .onAppear { loadBookThumbnail() }
        }
    }
    
    private func loadBookThumbnail() {
        if let stringUrl = book.volumeInfo.imageLinks?.thumbnail {
            if let url = URL(string: stringUrl) {
                
                DispatchQueue.global().async {
                    do {
                        let data = try Data(contentsOf: url)
                        DispatchQueue.main.async {
                            bookThumbnail = UIImage(data: data)
                        }
                    } catch {
                        print("No image data")
                    }
                }
            } else {
                print("Missing URL")
            }
        }
    }
}
