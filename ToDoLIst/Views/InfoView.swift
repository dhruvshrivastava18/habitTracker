//
//  InfoView.swift
//  ToDoLIst
//
//  Created by Dhruv's Macbook Pro  on 21/07/24.
//

import SwiftUI

struct InfoView: View {
    
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) private var dismiss
    
    @State private var selectedDate: Date = Date()    
    let modal: Modal
    
    var body: some View {
        NavigationView {
            ScrollView {
                Constants.images[modal.image].image
                    .resizable()
                    .frame(width: 25, height: 25)
                    .padding(.top)
                Text(modal.name)
                    .fontWeight(.semibold)
                    .padding(.top)
                
                HStack {
                    VStack(alignment: .leading, spacing: 8) {
                        Image(systemName: "flame")
                        
                        Text("\(modal.streak) Days")
                            .fontWeight(.semibold)
                        
                        Text("Current Streak")
                            .font(.caption2)
                    }
                    .padding(.leading)
                    Spacer()
                }
                .padding(.vertical)
                .foregroundColor(Color(hex: "7fdb7c"))
                .frame(minWidth: 0, maxWidth: UIScreen.main.bounds.width)
                .background(Color(hex: "093312"))
                .cornerRadius(16)
                .padding(.horizontal)
                HStack {
                    HStack {
                        VStack(alignment: .leading, spacing: 8) {
                            Image(.rocket)
                                .renderingMode(.template)
                                .resizable()
                                .frame(width: 20, height: 20)
                                .foregroundColor(Color(hex: "7fdb7c"))
                            
                            Text("\(findLongestStreak(modal.data, dailyTotal: modal.dailyTotal)) Days")
                                .fontWeight(.semibold)
                            
                            Text("Longest Streak")
                                .font(.caption2)
                        }
                        .padding(.leading)
                        Spacer()
                    }
                    .padding(.vertical)
                  
                    .frame(minWidth: 0, maxWidth: UIScreen.main.bounds.width)
                    .overlay(
                           RoundedRectangle(cornerRadius: 16)
                               .stroke(Color(hex: "093312"), lineWidth: 1)
                       )
                 
            
                    HStack {
                        VStack(alignment: .leading, spacing: 8) {
                            Image(systemName: "checkmark")
                                .foregroundColor(Color(hex: "7fdb7c"))
                            
                            Text("\(findTotalDaysCompleted(modal.data, dailyTotal: modal.dailyTotal)) Days")
                                .fontWeight(.semibold)
                            
                            Text("Total Completed")
                                .font(.caption2)
                        }
                        .padding(.leading)
                        Spacer()
                    }
                    .padding(.vertical)
              
                    .frame(minWidth: 0, maxWidth: UIScreen.main.bounds.width)
                    .overlay(
                           RoundedRectangle(cornerRadius: 16)
                               .stroke(Color(hex: "093312"), lineWidth: 1)
                       )
           
                    
                }
                .padding(.horizontal)
                
            }
            .toolbar {
                ToolbarItemGroup(placement: .topBarTrailing) {
                    Button {
                        deleteItem(modal)
                        dismiss()
                    } label: {
                        Image(systemName: "trash.fill")
                            .foregroundStyle(Constants.AppWhite)
                    }
                    
                    NavigationLink {
                        NewHabitView(modal: modal, isEdit: true)
                    } label: {
                        Image(systemName: "pencil")
                            .foregroundStyle(Constants.AppWhite)
                    }
                    
                }
                
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "chevron.left")
                            .foregroundStyle(Constants.AppWhite)
                    }
                }
            }
        }
    }
    
    private func deleteItem(_ item: Modal) {
        context.delete(item)
    }
    
}

#Preview {
    InfoView(modal: Modal(name: "Test", color: 3, image: 0, dailyTotal: 2, streak: 3, frequency: "", dailyData: [:]))
}
