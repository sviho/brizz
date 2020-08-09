//
//  Stopwatch.swift
//  Brizz
//
//  Created by Svitlana Honcharuk on 09.08.2020.
//  Copyright © 2020 Lana Honcharuk. All rights reserved.
//

import Foundation

class Stopwatch {
    
    private var startTime: Date?
    private var endTime: Date?

    var timePassed: TimeInterval {
        if let startTime = self.startTime {
            return -startTime.timeIntervalSinceNow
        } else {
            return 0
        }
    }
    
    var timePassedString: String {
        return String(format: "%02d:%02d:%02d",
                      Int(timePassed / 3600), Int(timePassed.truncatingRemainder(dividingBy: 3600) / 60), Int((timePassed).truncatingRemainder(dividingBy: 60)))
    }
    
    var isRunning: Bool {
        return startTime != nil
    }
    
    func start() {
        startTime = Date()
    }
    
    func stopAndPush(_ healthManager: HealthManager) {
        if startTime != nil {
            endTime = Date()
            healthManager.saveMindfulness(startTime!, endTime!)
        }
        startTime = nil
    }
    
}

