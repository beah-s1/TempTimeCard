//
//  TimeCardController.swift
//  TimeCard
//
//  Created by Kentaro Abe on 2021/07/30.
//

import Foundation
import RealmSwift

class TimeCardController: NSObject, ObservableObject{
    private let realm = try! Realm()
    
    @Published var currentPunch: PunchData?
    private var startTime: Date?
    private var endTime: Date?
    
    @Published var startTimeString = ""
    @Published var endTimeString = ""
    @Published var punchDataList: [PunchData] = []
    
    @Published var unpunchedTimeString: String = "0時間0分0秒"
    
    override init() {
        super.init()
        
        punchDataList = Array(realm.objects(PunchData.self).filter("isAppliedToOWR == %@", false).sorted(byKeyPath: "id", ascending: false))
        updateUnpunchedTime()
    }
    
    func start() {
        startTime = Date()
        
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY/MM/dd HH:mm:ss ~"
        
        startTimeString = formatter.string(from: startTime!)
    }
    
    func end() {
        endTime = Date()
        
        /*let workTime = endTime!.timeIntervalSince(startTime!)
        endTimeString = "勤務終了 勤務時間: \(Int(workTime)/3600)時間\(Int(workTime)/60)分\(Int(workTime)%60)秒"*/
        startTimeString = ""
        
        let newPunchData = PunchData()
        newPunchData.startTime = startTime!
        newPunchData.endTime = endTime!
        
        let currentWorkLog = realm.objects(PunchData.self).sorted(byKeyPath: "id", ascending: false)
        newPunchData.id = currentWorkLog.isEmpty ? 0 : currentWorkLog[0].id + 1
        
        try! realm.write {
            realm.add(newPunchData)
        }
        
        punchDataList = Array(realm.objects(PunchData.self).filter("isAppliedToOWR == %@", false).sorted(byKeyPath: "id", ascending: false))
        updateUnpunchedTime()
    }
    
    func changeToPunched(punchData: PunchData) {
        try! realm.write{
            punchData.isAppliedToOWR = true
        }
        
        punchDataList = Array(realm.objects(PunchData.self).filter("isAppliedToOWR == %@", false).sorted(byKeyPath: "id", ascending: false))
        updateUnpunchedTime()
    }
    
    func updateUnpunchedTime() {
        var workTimeSummary = 0
        for p in punchDataList{
            workTimeSummary += Int(p.workTime)
        }
        
        self.unpunchedTimeString = "\(workTimeSummary / 3600)時間\((workTimeSummary % 3600) / 60)分\((workTimeSummary % 3600) % 60)秒"
    }
}

class PunchData: Object, Identifiable{
    @Persisted var id: Int
    @Persisted var startTime: Date
    @Persisted var endTime: Date
    @Persisted var isAppliedToOWR: Bool = false
    
    var workTimeText: String{
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY/MM/dd HH:mm:ss"
        
        let distance = Int(self.endTime.timeIntervalSince(self.startTime))
        
        return "\(formatter.string(from: self.startTime)) ~ \(formatter.string(from: self.endTime)) 勤務時間:\(distance/3600)時間\((distance%3600)/60)分\((distance%3600)%60)秒"
    }
    
    var workTime: TimeInterval{
        return endTime.timeIntervalSince(startTime)
    }
}
