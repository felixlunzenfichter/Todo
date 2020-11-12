//
//  ContentView.swift
//  TodoApp
//
//  Created by Felix Lunzenfichter on 11.11.20.
//

import SwiftUI

struct ContentView: View {

    @ObservedObject var todos : TodoStorage = TodoStorage()
    @State var showAddTodoSheet = false
    @State var newTodoText = ""
    @State var showTodosDone = true
    @State var showTodosNotDone = true

    var body: some View {
        VStack {
            TopBar(showTodosDone: $showTodosDone, showTodosNotDone: $showTodosNotDone, showAddTodoSheet: $showAddTodoSheet, newTodoText: $newTodoText)
            TitleAndProgress(percentageDone: getPercentageDone())
            List{
                ForEach(todos.todoList) { todo in
                    if (todo.done && showTodosDone || !todo.done && showTodosNotDone) {
                        HStack {
                            Image(systemName: todo.done ? "circle.fill" : "circle").foregroundColor(todo.done ? .green : .red)
                            Text(todo.text)
                        }.onTapGesture(perform: {
                            todos.toggleTodoCheckboxFirestore(todo: todo)
                        })
                    }
                }.onDelete(perform: { indexSet in
                    indexSet.forEach {index in todos.deleteTodoInFirestore(todo: todos.todoList[index])}
                })
            }
        }.sheet(isPresented: $showAddTodoSheet, content: {
            VStack {
                Text("Add Todo")
                    .font(.largeTitle)
                    .fontWeight(.heavy)
                    .padding()
                LegacyTextField(text: $newTodoText, isFirstResponder: .constant(true)).border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/, width: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/).frame(width: 200, height: 1, alignment: .center).padding()
                Button(
                    action: {
                        todos.addTodoToFirestore(todo: Todo(text: newTodoText))
                        newTodoText = ""
                        showAddTodoSheet = false
                    },label: {
                        Text("Add New Todo")
                    }).padding()
                Spacer()
            }
        })
        .animation(.easeInOut)
    }
    
    func getPercentageDone() -> Int {
        let todosDone = todos.todoList.filter({todo in todo.done})
        if (todos.todoList.count == 0) {
            return 0
        } else {
            return Int(Double(todosDone.count)/Double(todos.todoList.count) * 100)
        }
    }
}

struct TitleAndProgress : View {
    
    var percentageDone : Int

    var body: some View {
        HStack {
            Text("Todos")
                .font(.largeTitle)
                .fontWeight(.heavy)
                .padding()
            Spacer()
            ProgressView(value: Double(percentageDone)/100).padding()
            Text("\(percentageDone)% done").frame(width: 60, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                .foregroundColor(percentageDone < 50 ? .red : (percentageDone < 75 ? .orange : (percentageDone < 100 ? .yellow : .green)))
        }
    }
}

struct TopBar : View {
    
    @Binding var showTodosDone : Bool
    @Binding var showTodosNotDone : Bool
    @Binding var showAddTodoSheet : Bool
    @Binding var newTodoText: String
    
    var body: some View {
        HStack {
            Spacer()
            Toggle(isOn: $showTodosDone, label: {
                Image(systemName: "circle.fill").foregroundColor(.green)
            }).padding(.horizontal).frame(width: 80.0)
            Toggle(isOn: $showTodosNotDone, label: {
                Image(systemName: "circle").foregroundColor(.red)
            }).padding(.horizontal).frame(width: 80.0)
            Button(
                action: {showAddTodoSheet.toggle(); newTodoText = ""},
                label: {Image(systemName: "plus")}
            ).padding()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
