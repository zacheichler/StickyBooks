

import SwiftUI

struct CellView: View {
    let book: Response.Book
    
    init(for book: Response.Book) {
        self.book = book
    }
    
    @State private var bookThumbnail: UIImage?
    
    var body: some View {
        NavigationLink(destination: SaveBook(for: book, image: bookThumbnail)) {
            LazyHStack(alignment: .top) {
                
                ZStack(alignment: .center){
                    
                    Rectangle()
                        .fill(Color("DarkBeige"))
                        .frame(width: 70, height: 70)
                        .cornerRadius(6)
                    ThumbnailCover(bookThumbnail: bookThumbnail).frame(width: 32, height: 46)
                    
                }
                
                
                
                
                
                LazyVStack(alignment: .leading) {
                    Text(book.volumeInfo.title).font(.headline)
                    
                    if let authors = book.volumeInfo.authors {
                        ForEach(authors, id: \.self){ author in
                            Text(author).font(.subheadline)
                        }
                    }
                }
                .frame(width: 225)
            }
            
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
