//
//  WeekView.swift
//  zadadnie7
//
//  Created by Przemek Pawlik on 20/01/2024.
//

import SwiftUI

struct WeekView: View {
    @State private var selectedDayIndex: Int?
    @State private var enteredDayOfWeek = ""
    @State private var isAlert = false
    @State private var message = ""
    
    let daysOfWeek = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"]
    
    var body: some View {
        VStack {
            Text("Week")
                .font(.largeTitle)
                .foregroundStyle(.blue)
                .bold()
            
            Form {
                Section(header: Text("Enter Day of Week")) {
                    TextField("Enter day", text: $enteredDayOfWeek)
                        .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                }
            }
            .onTapGesture {
                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
            }
            .frame(height: 100)
            .padding(.vertical, 15)
            
            Button(action: {
                getIndexForDay(enteredDayOfWeek)
            }) {
                Text("Submit")
                    .padding()
                    .foregroundColor(.white)
                    .bold()
                    .background(RoundedRectangle(cornerRadius: 10).foregroundColor(.blue))
                    .padding(.horizontal, 20)
            }
            .alert(isPresented: $isAlert) {
                Alert(title: Text("Error"), message: Text(message), dismissButton: .default(Text("OK")))
            }
            
            if selectedDayIndex != nil {
                HStack {
                    Button(action: {
                        self.moveDay(-1)
                    }) {
                        Image(systemName: "arrow.left")
                            .imageScale(.large)
                            .font(.title)
                    }.disabled(selectedDayIndex == 0)
                        .padding()
                    Spacer()
                    Text(daysOfWeek[selectedDayIndex!])
                        .font(.title)
                        .bold()
                    Spacer()
                    Button(action: {
                        self.moveDay(1)
                    }) {
                        Image(systemName: "arrow.right")
                            .imageScale(.large)
                            .font(.title)
                    }
                    .disabled(selectedDayIndex == daysOfWeek.count - 1)
                    .padding()
                }
            }
            
            Spacer()
        }
        .padding()
        
    }
    
    func getIndexForDay(_ dayText: String) {
        if dayText == "" {
            isAlert = true
            message = "Nothing provided"
            return
        }
        
        if let index = daysOfWeek.firstIndex(of: dayText) {
            selectedDayIndex = index
        } else {
            isAlert = true
            message = "Invalid day entered"
        }
        enteredDayOfWeek = ""
    }
    
    func moveDay(_ offset: Int) {
        let newIndex = (selectedDayIndex! + offset + daysOfWeek.count) % daysOfWeek.count
        selectedDayIndex = newIndex
    }
}


#Preview {
    WeekView()
}
