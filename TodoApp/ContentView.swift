//
//  ContentView.swift
//  TodoApp
//
//  Created by Felix Lunzenfichter on 11.11.20.
//

import SwiftUI

struct ContentView: View {

    @ObservedObject var todos : Todos = Todos()

    var body: some View {
        VStack {
            Button(
                action: {todos.todoList.append(Todo(text: "added"))},
                label: {Image(systemName: "plus")}
            )
            List{
                ForEach(todos.todoList) { todo in
                    HStack {
                        Text(todo.text)
                    }
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
