//
//  ContentView.swift
//  TimeCard
//
//  Created by Kentaro Abe on 2021/07/05.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var tcController = TimeCardController()
    
    var body: some View {
        VStack{
            Button(action: {
                tcController.start()
            }, label: {
                Text("勤務開始！")
            })
            
            Text(tcController.startTimeString)
            
            Button(action: {
                tcController.end()
            }, label: {
                Text("勤務終了！")
            })
            
            Text(tcController.endTimeString)
        }
        
        .padding()
        .frame(width: 300, height: 300, alignment: .center)
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
