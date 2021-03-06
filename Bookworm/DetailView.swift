//
//  DetailView.swift
//  Bookworm
//
//  Created by John Jeang on 6/10/21.
//

import CoreData
import SwiftUI

struct DetailView: View {
  let book: Book
  var body: some View {
    GeometryReader{ geometry in
      VStack {
        ZStack(alignment: .bottomTrailing) {
          Image(self.book.genre ?? "Fantasy")
            .frame(maxWidth: geometry.size.width)
          
          Text(self.book.genre?.uppercased() ?? "FANTASY")
            .font(.caption)
            .fontWeight(.black)
            .padding(8)
            .foregroundColor(.white)
            .background(Color.black.opacity(0.75))
            .clipShape(Capsule())
            .offset(x: -5, y:-5)
        }
        
        Text(self.book.author ?? "Unknown author")
          .font(.title)
          .foregroundColor(.secondary)
        
        Text(self.book.review ?? "No review")
        
        RatingView(rating: .constant(Int(self.book.rating)))
          .font(.largeTitle)
        
        Spacer()
      }
    }
    .navigationBarTitle(Text(book.title ?? "Unknown Book"), displayMode: .inline)
  }
}

struct DetailView_Previews: PreviewProvider {
  
  static let viewContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
  
  static var previews: some View {
    let book = Book(context: viewContext)
    book.title = "Test book"
    book.author = "Test author"
    book.genre = "Fantasy"
    book.rating = 4
    book.review = "This was a great book; I really enjoyed it."
    return NavigationView{
      DetailView(book: book)
    }
  }
}
