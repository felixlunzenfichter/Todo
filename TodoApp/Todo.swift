//
//  Todo.swift
//  TodoApp
//
//  Created by Felix Lunzenfichter on 11.11.20.
//

import Foundation

class Todo : Identifiable {

    init (text: String = "empty", done: Bool = false) {
        self.text = text
        self.done = done
    }

    var text: String = "empty"
    var done: Bool = false
}

class Todos: ObservableObject {
   @Published var todoList: [Todo] = []
}
