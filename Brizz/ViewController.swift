//
//  ViewController.swift
//  Brizz
//
//  Created by Svitlana Honcharuk on 09.08.2020.
//  Copyright © 2020 Lana Honcharuk. All rights reserved.
//

import UIKit

class ViewController: UIViewController, AlertDelegate {
    
    @IBOutlet weak var timePassedLabel: UILabel!
    let stopwatch = Stopwatch()
    let healthManager = HealthManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        healthManager.delegate = self
    }
    
    @objc @IBAction func startButtonTapped(_ sender: UIButton) {
        Timer.scheduledTimer(timeInterval: 0.1, target: self,
            selector: #selector(ViewController.updateElapsedTimeLabel(_:)), userInfo: nil, repeats: true)
        stopwatch.start()
    }
    
    @IBAction func stopButtonTapped(_ sender: UIButton) {
        stopwatch.stopAndPush(healthManager)
    }
    
    @objc func updateElapsedTimeLabel(_ timer: Timer) {
        if stopwatch.isRunning {
            timePassedLabel.text = stopwatch.timePassedString
        } else {
            timer.invalidate()
        }
    }
    
    @IBAction func showAccessAlert() {
        let alertController = UIAlertController(title: "No Access to Apple Health", message:
            "Please, give a permission to access your health data in Settings", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Okay", style: .default))

        self.present(alertController, animated: true, completion: nil)
    }
}

protocol AlertDelegate {
    func showAccessAlert()
}
