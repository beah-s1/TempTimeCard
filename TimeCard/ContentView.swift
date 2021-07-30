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
            
            List {
                ForEach(tcController.punchDataList){ punch in
                    HStack{
                        Text(punch.workTimeText)
                        Button("打刻済みにする") {
                            tcController.changeToPunched(punchData: punch)
                        }
                    }
                }
                Text("------------------------------")
                Text("未打刻時間合計: \(tcController.unpunchedTimeString)")
            }
        }
        
        .padding()
        .frame(width: 600, height: 300, alignment: .center)
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
