//
//  ContentView.swift
//  CoreDataSwiftUI
//
//  Created by Venkatesh on 2/29/20.
//  Copyright © 2020 Venkatesh. All rights reserved.
//

import SwiftUI
import CoreData

struct ContentView: View {
    
    @Environment(\.managedObjectContext) var managedObjContext
    @FetchRequest(fetchRequest: TodoItem.getAllTodoItems()) var todoItems : FetchedResults<TodoItem>
    @State var newTask = ""
    
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("It's a list")) {
                    HStack {
                        TextField("Enter your task", text: $newTask)
                        Button(action: {
                            let todo = TodoItem(context: self.managedObjContext)
                            todo.id = UUID()
                            todo.desc = self.newTask
                            todo.created_date = Date()
                            do {
                                try self.managedObjContext.save()
                            } catch {
                                print(error)
                            }
                            self.newTask = ""
                        }) {
                            Image(systemName: "plus.circle.fill")
                                .foregroundColor(Color.green)
                        }
                    }
                }
                Section(header: Text("Tasks added")) {
                    ForEach(self.todoItems) { todoItem in
                        Text(todoItem.desc ?? "")
                    }.onDelete { (indexSet) in
                        let deleteItem = self.todoItems[indexSet.first!]
                        self.managedObjContext.delete(deleteItem)
                        do {
                            try self.managedObjContext.save()
                        } catch {
                            print(error)
                        }
                    }
                }
            }.navigationBarTitle("ToDo")
                .navigationBarItems(trailing: EditButton())
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
