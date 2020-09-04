//
//  AlarmView.swift
//  Clock
//
//  Created by 현기엽 on 2020/09/04.
//  Copyright © 2020 현기엽. All rights reserved.
//

import SwiftUI

struct AlarmView: View {
    @ObservedObject var model: Alarm
    
    var body: some View {
        Text("Hello, World!")
    }
}

struct AlarmView_Previews: PreviewProvider {
    static var previews: some View {
        AlarmView(model: Alarm())
    }
}
