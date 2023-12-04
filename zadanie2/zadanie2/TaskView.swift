//
//  TaskView.swift
//  zadanie2
//
//  Created by Przemek Pawlik on 04/12/2023.
//

import Foundation
import SwiftUI

struct TaskView: View {
    let task: Task
    
    var body: some View {
        VStack {
            Text(task.title)
                .font(.title)
                .padding()
            Image(task.image)
                .resizable()
                .scaledToFit()
                .frame(height: 200)
            Spacer()
        }
        .navigationBarTitle(task.title, displayMode: .inline)
    }
}
