//
//  TodoItem.swift
//  CoreDataSwiftUI
//
//  Created by Venkatesh on 2/29/20.
//  Copyright © 2020 Venkatesh. All rights reserved.
//

import Foundation
import CoreData

class TodoItem: NSManagedObject,Identifiable {
    @NSManaged var id: UUID?
    @NSManaged var desc: String?
    @NSManaged var created_date: Date?

}

extension TodoItem {
    class func getAllTodoItems() -> NSFetchRequest<TodoItem> {
        let request = TodoItem.fetchRequest() as! NSFetchRequest<TodoItem>
        let sortDesc = NSSortDescriptor(key: "created_date", ascending: true)
        request.sortDescriptors = [sortDesc]
        return request
    }
}
