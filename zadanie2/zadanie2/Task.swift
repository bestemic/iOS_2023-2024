//
//  Task.swift
//  zadanie2
//
//  Created by Przemek Pawlik on 04/12/2023.
//

import Foundation

struct Task: Identifiable {
    let id: Int
    let title: String
    let image: String
    var status: TaskStatus?
}
