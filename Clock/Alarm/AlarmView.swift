//
//  AlarmView.swift
//  Clock
//
//  Created by 현기엽 on 2020/09/04.
//  Copyright © 2020 현기엽. All rights reserved.
//

import SwiftUI

struct AlarmView: View {
    @ObservedObject var model: AlarmModel
    @FetchRequest(
        entity: Alarm.entity(),
        sortDescriptors: [NSSortDescriptor(key: "order", ascending: true)]
    ) var alarms: FetchedResults<Alarm>
    @State private var editMode = EditMode.inactive
    @State var isAdding = false
    @Environment(\.managedObjectContext) var managedObjectContext
    
    var body: some View {
        VStack {
            NavigationView {
                ZStack {
                    AlarmViewList(
                        model: model,
                        alarms: Binding.constant(alarms),
                        editMode: $editMode
                    )
                    if alarms.isEmpty {
                        Text("알람 없음")
                            .font(.title)
                            .foregroundColor(.gray)
                    }
                }
                .navigationBarTitle("알람")
                .navigationBarItems(
                    leading: Group {
                        if !alarms.isEmpty {
                            EditButton()
                        }
                    },
                    trailing: Image(systemName: "plus").onTapGesture {
                        isAdding = true
                    }
                )
                .environment(\.editMode, $editMode)
            }
            // https://stackoverflow.com/a/57632426
            EmptyView().sheet(isPresented: $isAdding) {
                EmptyView().onAppear {
                    let alarm = Alarm(context: managedObjectContext)
                    alarm.order = 1
                    saveContext()
                }
            }
            .fixedSize()
        }
    }
    
    func saveContext() {
        do {
            try managedObjectContext.save()
        } catch {
            print("Error saving managed object context: \(error)")
        }
    }
}

struct AlarmViewList: View {
    var model: AlarmModel
    @Binding var alarms: FetchedResults<Alarm>
    @Binding var editMode: EditMode
    
    var body: some View {
        List {
            ForEach(alarms) { alarm in
                AlarmEntityView(alarm: alarm, editMode: $editMode)
            }
        }
    }
}

struct AlarmEntityView: View {
    var alarm: Alarm
    @Binding var editMode: EditMode
    
    var body: some View {
        Text("stub")
    }
}

struct AlarmView_Previews: PreviewProvider {
    static var previews: some View {
        AlarmView(model: AlarmModel())
    }
}
