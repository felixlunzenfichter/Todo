//
//  Todo.swift
//  TodoApp
//
//  Created by Felix Lunzenfichter on 11.11.20.
//

import Foundation

class Todo : Identifiable {

    init (text: String) {
        self.text = text
    }

    var text: String = "empty"
    var done: Bool = false
}

class Todos: ObservableObject {
   @Published var todoList: [Todo] = [Todo(text: "testTodo")]
}
