//
//  ScoreViewController.swift
//  swiftsummay
//
//  Created by xubojoy on 2018/4/3.
//  Copyright © 2018年 xubojoy. All rights reserved.
//

import UIKit

class ScoreViewController: UIViewController {

    var score:ScoreView!
    var bestscore:ScoreView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        setupScoreLabels();
    }
    
    func setupScoreLabels()
    {
        score = ScoreView(stype: .common)
        score.frame.origin = CGPoint(x:50, y:180)
        score.changeScore(value: 0)
        self.view.addSubview(score)
        
        bestscore = ScoreView(stype: .best)
        bestscore.frame.origin.x = 170
        bestscore.frame.origin.y = 180
        bestscore.changeScore(value: 99)
        self.view.addSubview(bestscore)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
