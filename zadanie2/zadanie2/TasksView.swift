//
//  ContentView.swift
//  zadanie2
//
//  Created by Przemek Pawlik on 04/12/2023.
//

import SwiftUI

let tasks = [
    Task(id: 1, title: "Zadanie 1", image: "image1"),
    Task(id: 2, title: "Zadanie 2", image: "image2"),
    Task(id: 3, title: "Zadanie 3", image: "image3"),
    Task(id: 4, title: "Zadanie 4", image: "image4")
]

struct TasksView: View {
    
    var body: some View {
        NavigationView {
            List(tasks, id: \.id) { task in
                NavigationLink(destination: TaskView(task: task)) {
                    HStack {
                        Text(task.title)
                    }
                }
            }
            .navigationBarTitle("Lista Zadań", displayMode: .inline)
        }
    }
}

#Preview {
    TasksView()
}
