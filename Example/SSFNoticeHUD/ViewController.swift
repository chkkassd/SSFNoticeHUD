//
//  ViewController.swift
//  SSFNoticeHUD
//
//  Created by Peter Shi on 07/25/2019.
//  Copyright (c) 2019 Peter Shi. All rights reserved.
//

import UIKit
import SSFNoticeHUD

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func press1(_ sender: Any) {
        _ = self.SSFNoticeSuccess(text: "Success \nHello world", autoClear: true, delay: 2)
    }

    @IBAction func press2(_ sender: Any) {
        _ = self.SSFNoticeError(text: "Error", autoClear: true, delay: 2)
    }
    @IBAction func press3(_ sender: Any) {
        _ = self.SSFNoticeInfo(text: "infoinfo", autoClear: true, delay: 2)
    }
    @IBAction func press4(_ sender: Any) {
        _ = self.SSFNoticeForOnlyText(text: "I love you\nkkkkkjjjjjdddjdjdjdjdjdjdjdj i am a brid haha haha", autoClear: true, delay: 2)
    }

    @IBAction func press5(_ sender: Any) {
        _ = self.SSFNoticeForStandardLoading(text: "Loading...\n hello world\ni am a dog dog dog dog dog dog cat, hehe hehe", autoClear: true, delay: 2)
    }

    @IBAction func press6(_ sender: Any) {
        _ = self.SSFNoticeForOnlyLoading(autoClear: true, delay: 2)
    }

    @IBAction func press7(_ sender: Any) {
        _ = self.SSFNoticeTopSuccess(text: "Success", autoClear: true, delay: 2)
    }
    @IBAction func press8(_ sender: Any) {
        _ = self.SSFNoticeTopError(text: "Error", autoClear: true, delay: 2)
    }
}

