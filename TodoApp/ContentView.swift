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
            HStack {
                Spacer()
                Button(
                    action: {showAddTodoSheet.toggle()},
                    label: {Image(systemName: "plus")}
                ).padding()
            }
            HStack {
                Text("Todos")
                    .font(.largeTitle)
                    .fontWeight(.heavy)
                    .padding()
                Spacer()
            }
            List{
                ForEach(todos.todoList) { todo in
                    HStack {
                        Image(systemName: todo.done ? "circle.fill" : "circle").foregroundColor(todo.done ? .green : .red)
                        Text(todo.text)
                    }.onTapGesture(perform: {
                        todo.done.toggle()
                        todos.objectWillChange.send()
                    })
                }.onDelete(perform: { indexSet in
                    indexSet.forEach {index in todos.todoList.remove(at: index)}
                })
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
