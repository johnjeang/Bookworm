//
//  ContentView.swift
//  Bookworm
//
//  Created by John Jeang on 6/8/21.
//

import SwiftUI
import CoreData

struct ContentView: View {
  @Environment(\.managedObjectContext) private var viewContext
  
  @FetchRequest(entity: Book.entity(), sortDescriptors: []) var books: FetchedResults<Book>
  
  @State private var showingAddScreen = false
  
  
  
  var body: some View {
    NavigationView{
      
      List {
        ForEach(books, id: \.self) { book in
          NavigationLink(destination: DetailView(book: book)) {
            EmojiRatingView(rating: book.rating)
              .font(.largeTitle)
            VStack(alignment: .leading) {
              Text(book.title ?? "Uknown Title")
                .font(.headline)
              Text(book.author ?? "Unknown Author")
                .foregroundColor(.secondary)
            }
            
          }
        }
      }
      .navigationBarTitle("Bookworm")
      .navigationBarItems(trailing: Button(action: {
        showingAddScreen.toggle()
      }, label: {
        Image(systemName: "plus")
      }))
    }
    .sheet(isPresented: $showingAddScreen, content: {
      AddBookView().environment(\.managedObjectContext, viewContext)
    })
    
  }
  
  private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
  }()
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
  }
}

