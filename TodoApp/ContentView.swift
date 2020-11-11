//
//  ContentView.swift
//  TodoApp
//
//  Created by Felix Lunzenfichter on 11.11.20.
//

import SwiftUI

struct ContentView: View {

    var todos : Todos = Todos()

    var body: some View {
        List{
            ForEach(todos.todoList) { todo in
                HStack {
                    Text(todo.text)
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
