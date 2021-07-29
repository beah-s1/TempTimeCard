//
//  ContentView.swift
//  TimeCard
//
//  Created by Kentaro Abe on 2021/07/05.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack{
            Button(action: {
                
            }, label: {
                Text("勤務開始！")
            })
            Button(action: {
                
            }, label: {
                Text("勤務終了！")
            })
            .padding()
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
