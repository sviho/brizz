//
//  HealthManager.swift
//  Brizz
//
//  Created by Svitlana Honcharuk on 09.08.2020.
//  Copyright © 2020 Lana Honcharuk. All rights reserved.
//

import Foundation
import HealthKit

class HealthManager {
    
    let healthStore = HKHealthStore()
    var delegate: AlertDelegate?
    
    func saveMindfulness(_ startTime: Date, _ endTime: Date) {
        let mindfulness = HKObjectType.categoryType(forIdentifier: .mindfulSession)!
        let allTypes = Set([mindfulness])

        healthStore.requestAuthorization(toShare: allTypes, read: allTypes) { (success, error) in
            if !success {
                self.delegate!.showAccessAlert()
            }
            
            let mindfulSample = HKCategorySample(type: mindfulness, value: 0, start: startTime, end: endTime)
            
            self.healthStore.save(mindfulSample, withCompletion: { (success, error) -> Void in
                if success {
                    print("The data was saved in Apple Health")
                } else {
                    DispatchQueue.main.async {
                        self.delegate!.showAccessAlert()
                    }
                }
            })
        }
    }
    
}
