//
//  AVPlayerViewController.swift
//  swiftsummay
//
//  Created by xubojoy on 2018/4/13.
//  Copyright © 2018年 xubojoy. All rights reserved.
//

import UIKit
import AVFoundation
class AVPlayerViewController: UIViewController {

    @IBOutlet var playButton: UIButton!
    
    
    @IBOutlet var playbackSlider: UISlider!
    
    
    @IBOutlet var playTime: UILabel!
    
    //播放器相关
    var playerItem: AVPlayerItem?
    var player: AVPlayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        // Do any additional setup after loading the view.
        
        //播放本地音乐
        let path = Bundle.main.path(forResource: "yuema", ofType: "mp3")
        playerItem = AVPlayerItem(url: URL(fileURLWithPath: path!))
        
        //播放在线音乐
//        let url = URL(string: "http://mxd.766.com/sdo/music/data/3/m10.mp3")
//        playerItem = AVPlayerItem(url: url!)
        player = AVPlayer(playerItem: playerItem!)
        
        
        let duration:CMTime = (playerItem?.asset.duration)!
        let seconds:Float64 = CMTimeGetSeconds(duration)
        
        playbackSlider.minimumValue = 0
        playbackSlider.maximumValue = Float(seconds)
        playbackSlider.isContinuous = false
        
        //播放过程中动态改变进度条值和时间标签
        player?.addPeriodicTimeObserver(forInterval: CMTimeMakeWithSeconds(1, 1), queue: DispatchQueue.main, using: { (CMTime) in
            if self.player?.currentItem?.status == .readyToPlay {
                //更新进度条进度值
                let currentTime = CMTimeGetSeconds(self.player!.currentTime())
                self.playbackSlider!.value = Float(currentTime)
                //一个小算法，来实现00：00这种格式的播放时间
                let all:Int=Int(currentTime)
                let m:Int=all % 60
                let f:Int=Int(all/60)
                var time:String=""
                if f<10{
                    time="0\(f):"
                }else {
                    time="\(f)"
                }
                if m<10{
                    time+="0\(m)"
                }else {
                    time+="\(m)"
                }
                //更新播放时间
                self.playTime!.text=time
            }
        })
    }
    
    
    @IBAction func playButtonTapped(_ sender: Any) {
        
        //根据rate属性判断当天是否在播放
        
        if player?.rate == 0 {
            player?.play()
            playButton.setTitle("暂停", for: .normal)
        } else {
            player?.pause()
            playButton.setTitle("播放", for: .normal)
        }
        
    }
    
    
    @IBAction func playbackSliderValueChanged(_ sender: Any) {
        
        let seconds : Int64 = Int64(playbackSlider.value)
        let targetTime:CMTime = CMTimeMake(seconds, 1)
        //播放器定位到对应的位置
        player?.seek(to: targetTime)
        //如果当前时暂停状态，则自动播放
        if player?.rate == 0 {
            player?.play()
            playButton.setTitle("暂停", for: .normal)
        }
    }
    
    //页面显示时添加歌曲播放结束通知监听
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(finishedPlaying),
                                               name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: playerItem)
    }
    
    //页面消失时取消歌曲播放结束通知监听
    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self)
    }
    
    //歌曲播放完毕
    @objc func finishedPlaying(myNotification:NSNotification) {
        print("播放完毕!")
        let stopedPlayerItem = myNotification.object as! AVPlayerItem
        stopedPlayerItem.seek(to: kCMTimeZero, completionHandler: nil)
        playButton.setTitle("播放", for: .normal)
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
