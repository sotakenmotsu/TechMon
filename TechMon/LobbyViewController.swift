//
//  LobbyViewController.swift
//  TechMon
//
//  Created by 剱物蒼太 on 2016/03/27.
//  Copyright © 2016年 剱物蒼太. All rights reserved.
//

import UIKit
import AVFoundation

class LobbyViewController: UIViewController ,AVAudioPlayerDelegate {
    
    var stamina: Float = 0
    var staminaTimer: NSTimer!
    var util: TechDraUtility!
    var player: Player!
    
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var staminaBar: UIProgressView!
    @IBOutlet var levelLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        player = Player(name: "勇者", imageName: "yusya.png")
        staminaBar.transform = CGAffineTransformMakeScale(1.0, 4.0)
        
        nameLabel.text = player.name
        levelLabel.text = "Lv.15"
        stamina = 100
        
        util = TechDraUtility()
        
        cureStamina()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
        util.playBGM("lobby")
    }
    
    override func viewWillDisappear(animated: Bool) {
        util.stopBGM()
    }
    
    @IBAction func toBattle() {
        
        if stamina >= 50 {
            stamina = stamina - 50
            staminaBar.progress = stamina / 100
            
            self.performSegueWithIdentifier("toBattle", sender: nil)
        }else{
            let alert = UIAlertController(title: "バトルに行けません。", message: "スタミナを溜めて下さい。", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "OK", style: .Default, handler:nil))
            self.presentViewController(alert, animated: true, completion: nil)
        }
    }
        
    func cureStamina() {
        
        staminaTimer = NSTimer.scheduledTimerWithTimeInterval(3.0, target: self, selector: "updateStaminaValue", userInfo: nil, repeats: true)
        staminaTimer.fire()
    }
        
    func updateStaminaValue() {
        
        if stamina <= 100 {
            stamina = stamina + 1
            staminaBar.progress = stamina / 100
        }
    }

    
}