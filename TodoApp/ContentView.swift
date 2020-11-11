//
//  ContentView.swift
//  TodoApp
//
//  Created by Felix Lunzenfichter on 11.11.20.
//

import SwiftUI
import Firebase
import FirebaseFirestore

struct ContentView: View {

    @ObservedObject var todos : Todos = Todos()
    @State var showAddTodoSheet = false
    @State var newTodoText = ""
    @State var showTodosDone = true
    @State var showTodosNotDone = true
    let db = Firestore.firestore()
    
    init() {
        listenToChangesFirestore()
    }

    var body: some View {
        VStack {
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
            HStack {
                Text("Todos")
                    .font(.largeTitle)
                    .fontWeight(.heavy)
                    .padding()
                Spacer()
                ProgressView(value: Double(getPercentageDone())/100).padding()
                Text("\(getPercentageDone())% done").frame(width: 60, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .foregroundColor(getPercentageDone() < 50 ? .red : (getPercentageDone() < 75 ? .orange : (getPercentageDone() < 100 ? .yellow : .green)))
            }
            List{
                ForEach(todos.todoList) { todo in
                    if (todo.done && showTodosDone || !todo.done && showTodosNotDone) {
                        HStack {
                            Image(systemName: todo.done ? "circle.fill" : "circle").foregroundColor(todo.done ? .green : .red)
                            Text(todo.text)
                        }.onTapGesture(perform: {
                            todo.done.toggle()
                            todos.objectWillChange.send()
                        })
                    }
                }.onDelete(perform: { indexSet in
                    indexSet.forEach {index in deleteTodoInFirestore(todo: todos.todoList[index])}
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
                        addTodoToFirestore(todo: Todo(text: newTodoText))
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
        return Int(Double(todosDone.count)/Double(todos.todoList.count) * 100)
    }
}

extension ContentView {
    
    func listenToChangesFirestore() {
        db.collection("todos")
            .addSnapshotListener { querySnapshot, error in
                guard let snapshot = querySnapshot else {
                    print("Error fetching snapshots: \(error!)")
                    return
                }
                snapshot.documentChanges.forEach { diff in
                    if (diff.type == .added) {
                        let todoFromFirestore = diff.document.data()
                        print("New city: \(diff.document.data())")
                        var todo : Todo
                        todo = Todo(text: todoFromFirestore["text"] as! String, done: todoFromFirestore["done"] as! Bool)
                        todos.todoList.append(todo)
                    }
                    if (diff.type == .modified) {
                        print("Modified city: \(diff.document.data())")
                    }
                    if (diff.type == .removed) {
                        let todoFromFirestore = diff.document.data()
                        print("removed \(todoFromFirestore["text"])")
                    }
                }
            }
    }
    
    
    func addTodoToFirestore(todo: Todo) {
        // Add a new document in collection "cities"
        db.collection("todos").document(todo.text).setData([
            "text": todo.text,
            "done": todo.done,
        ]) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }
    }
    
//    func toggleTodoCheckboxFirestore(todo: Todo) {
//        let todoRef = db.collection("todos").document(todo.text)
//        todoRef.updateData([
//            "done": !todo.done
//        ]) { err in
//            if let err = err {
//                print("Error updating document: \(err)")
//            } else {
//                print("Document successfully updated")
//            }
//        }
//    }
    
    func deleteTodoInFirestore(todo: Todo) {
        db.collection("todos").document(todo.text).delete() { err in
            if let err = err {
                print("Error removing document: \(err)")
            } else {
                print("Document successfully removed!")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
