//
//  AddBookView.swift
//  Bookworm
//
//  Created by John Jeang on 6/9/21.
//

import SwiftUI

struct AddBookView: View {
  @Environment(\.managedObjectContext) var viewContext
  @Environment(\.presentationMode) var presentationMode
  
  @State private var title = ""
  @State private var author = ""
  @State private var rating = 3
  @State private var genre = ""
  @State private var review = ""
  
  let genres = ["Fantasy", "Horror", "Kids", "Mystery", "Poetry", "Romance", "Thriller"]
  
  var body: some View {
    NavigationView{
      Form{
        Section{
          TextField("Name of book", text: $title)
          TextField("Author's name", text: $author)
          
          Picker("Genre", selection: $genre){
            ForEach(genres, id: \.self){
              Text($0)
            }
          }
        }
        Section {
          Picker("Rating", selection : $rating) {
            ForEach(0..<6) {
              Text("\($0)")
            }
          }
        }
        Section{
          RatingView(rating: $rating)
          
          TextField("Write a review", text: $review)
        }
        
        Section{
          Button("Save"){
            let newBook = Book(context: viewContext)
            
            newBook.title = title
            newBook.review = review
            newBook.rating = Int16(rating)
            newBook.genre = genre
            newBook.author = author
            
            try? viewContext.save()
            presentationMode.wrappedValue.dismiss()

          }
        }
      }
      .navigationBarTitle("Add Book")
    }
    

  }
}

struct AddBookView_Previews: PreviewProvider {
  static var previews: some View {
    AddBookView()
  }
}
