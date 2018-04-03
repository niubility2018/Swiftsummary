//
//  MusicPlayViewController.swift
//  swiftsummay
//
//  Created by xubojoy on 2018/4/3.
//  Copyright © 2018年 xubojoy. All rights reserved.
//

import UIKit
import MediaPlayer

class MusicPlayViewController: UIViewController {

    var audioPlayer = MPMoviePlayerController()
    var timer = Timer()
    
    var progressView = UIProgressView()
    var playTime = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.progressView = UIProgressView(frame: CGRect(x: 20, y: 100, width: 200, height: 10))
        self.progressView.progressViewStyle = .bar
        self.view.addSubview(self.progressView)
        
        
        self.playTime = UILabel(frame: CGRect(x: 240, y: 95, width: 60, height: 20))
        
        self.playTime.textAlignment = .center
        self.playTime.textColor = .black
        self.playTime.text = "00:00"
        self.playTime.font = UIFont.systemFont(ofSize: 12)
        self.view.addSubview(self.playTime)
        
        onSetAudio(url: "http://www.hangge.com/mp3/music.mp3")
        
    }

    //播放歌曲
    func onSetAudio(url:String){
        self.audioPlayer.stop()
        self.audioPlayer.contentURL = URL(string: url)
        self.audioPlayer.play()
//        self.audioPlayer.
        self.timer.invalidate()
        self.playTime.text = "00:00"
        
        self.timer = Timer.scheduledTimer(timeInterval: 0.4, target: self, selector: #selector(onUpdate), userInfo: nil, repeats: true)
        
    }
    
    @objc func onUpdate() {
        let c = self.audioPlayer.currentPlaybackTime
        if c > 0.0 {
            let t = self.audioPlayer.duration
            let p:CGFloat = CGFloat(c/t)
            self.progressView.setProgress(Float(p), animated: true)
            
            let all:Int = Int(c)
            
            let m:Int = all % 60
            
            let f:Int = Int(all/60)
            var time:String = ""
            
            if f<10{
                time = "0\(f)"
            }else{
                time = "\(f)"
            }
            
            
            
            if m<10{
                time += "0\(m)"
            }else{
                time += "\(m)"
            }
            
            
            self.playTime.text = time
            
        }
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
