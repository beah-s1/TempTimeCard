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
    
    /*var startTimeString: String {
        if currentPunch != nil{
            let formatter = DateFormatter()
            formatter.dateFormat = "勤務開始:YYYY/MM/dd HH:mm"
            
            return formatter.string(from: currentPunch!.startTime!)
        }
        
        return ""
    }
    
    var endTimeString: String {
        if currentPunch != nil{
            
        }
        
        return ""
    }*/
    
    func start() {
        startTime = Date()
        
        let formatter = DateFormatter()
        formatter.dateFormat = "勤務開始:YYYY/MM/dd HH:mm"
        
        startTimeString = formatter.string(from: startTime!)
    }
    
    func end() {
        /*guard let localPunchData = currentPunch else{
            return
        }
        
        let punchData = realm.objects(PunchData.self).filter { p in
            return p.id == localPunchData.id
        }
        if punchData.isEmpty{
            return
        }
        
        try! realm.write {
            punchData[0].endTime = Date()
        }
        
        currentPunch = nil*/
        
        endTime = Date()
        
        let formatter = DateFormatter()
        formatter.dateFormat = "勤務終了:YYYY/MM/dd HH:mm"
        
        endTimeString = formatter.string(from: endTime!)
    }
}

class PunchData: Object{
    @Persisted var id: Int
    @Persisted var startTime: Date?
    @Persisted var endTime: Date?
    @Persisted var isAppliedToOWR: Bool = false
}
