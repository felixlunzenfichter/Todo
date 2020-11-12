//
//  TodoStorage.swift
//  TodoApp
//
//  Created by Felix Lunzenfichter on 12.11.20.
//

import Foundation
import Firebase
import FirebaseFirestore

class TodoStorage: ObservableObject {
    
    init() {
        listenToChangesFirestore()
    }
    
    let db = Firestore.firestore()
    
   @Published var todoList: [Todo] = []
    
    fileprivate func addTodoToLocalList(_ diff: DocumentChange) {
        let todoFromFirestore = diff.document.data()
        print("New city: \(diff.document.data())")
        var todo : Todo
        todo = Todo(text: todoFromFirestore["text"] as! String, done: todoFromFirestore["done"] as! Bool)
        todoList.append(todo)
    }
    
    fileprivate func updateTodoInLocalList(_ diff: DocumentChange) {
        print("Modified city: \(diff.document.data())")
        let toggledTodo = diff.document.data()
        let index = todoList.firstIndex(where: {todo in todo.text == toggledTodo["text"] as? String})
        todoList[index!].done = toggledTodo["done"] as! Bool
        objectWillChange.send()
    }
    
    fileprivate func removeTodoFromLocalList(_ diff: DocumentChange) {
        let todoFromFirestore = diff.document.data()
        print("removed \(todoFromFirestore["text"] ?? "default value")")
        todoList.removeAll(where: {todo in todo.text == todoFromFirestore["text"] as! String})
    }
    
    func listenToChangesFirestore() {
        db.collection("todos")
            .addSnapshotListener { querySnapshot, error in
                guard let snapshot = querySnapshot else {
                    print("Error fetching snapshots: \(error!)")
                    return
                }
                snapshot.documentChanges.forEach { diff in
                    if (diff.type == .added) {
                        self.addTodoToLocalList(diff)
                    }
                    if (diff.type == .modified) {
                        self.updateTodoInLocalList(diff)
                    }
                    if (diff.type == .removed) {
                        self.removeTodoFromLocalList(diff)
                    }
                }
            }
    }
    
    
    func addTodo(todo: Todo) {
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
    
    func toggleTodo(todo: Todo) {
        let todoRef = db.collection("todos").document(todo.text)
        todoRef.updateData([
            "done": !todo.done
        ]) { err in
            if let err = err {
                print("Error updating document: \(err)")
            } else {
                print("Document successfully updated")
            }
        }
    }
    
    func deleteTodo(todo: Todo) {
        db.collection("todos").document(todo.text).delete() { err in
            if let err = err {
                print("Error removing document: \(err)")
            } else {
                print("Document successfully removed!")
            }
        }
    }
}

