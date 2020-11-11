//
//  ContentView.swift
//  TodoApp
//
//  Created by Felix Lunzenfichter on 11.11.20.
//

import SwiftUI

struct ContentView: View {

    @ObservedObject var todos : Todos = Todos()
    @State var showAddTodoSheet = false
    @State var newTodoText = ""

    var body: some View {
        VStack {
            Button(
                action: {showAddTodoSheet.toggle()},
                label: {Image(systemName: "plus")}
            )
            List{
                ForEach(todos.todoList) { todo in
                    HStack {
                        Text(todo.text)
                    }
                }
            }
        }.sheet(isPresented: $showAddTodoSheet, content: {
            Text("Add Todo")
            TextField("Enter Todo description", text: $newTodoText)
            Button(
                action: {
                    todos.todoList.append(Todo(text: newTodoText))
                    newTodoText = ""
                    showAddTodoSheet = false
                },label: {
                    Text("Add New Todo")
            })
        })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
