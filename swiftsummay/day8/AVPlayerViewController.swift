//
//  AVPlayerViewController.swift
//  swiftsummay
//
//  Created by xubojoy on 2018/4/13.
//  Copyright © 2018年 xubojoy. All rights reserved.
//

import UIKit
import AVFoundation
import MediaPlayer
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
            if self.player?.currentItem?.status == .readyToPlay && self.player?.rate != 0{
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
                //设置后台播放显示信息
                self.setInfoCenterCredentials(playbackState: 1)
            }
        })
    }
    
    
    // 设置后台播放显示信息
    func setInfoCenterCredentials(playbackState: Int) {
        let mpic = MPNowPlayingInfoCenter.default()
        
        //专辑封面
        let mySize = CGSize(width: 400, height: 400)
        var albumArt: MPMediaItemArtwork
        if #available(iOS 10.0, *) {
            albumArt = MPMediaItemArtwork(boundsSize:mySize) { sz in
                return UIImage(named: "swift")!
            }
        } else {
            // Fallback on earlier versions
            albumArt = MPMediaItemArtwork(image: UIImage(named: "swift")!)
        }
        
        //获取进度
        let postion = Double(self.playbackSlider!.value)
        let duration = Double(self.playbackSlider!.maximumValue)
        
        mpic.nowPlayingInfo = [MPMediaItemPropertyTitle: "看我跃马扬鞭",
                               MPMediaItemPropertyArtist: "西游记",
                               MPMediaItemPropertyArtwork: albumArt,
                               MPNowPlayingInfoPropertyElapsedPlaybackTime: postion,
                               MPMediaItemPropertyPlaybackDuration: duration,
                               MPNowPlayingInfoPropertyPlaybackRate: playbackState]
    }
    
    //后台操作
    override func remoteControlReceived(with event: UIEvent?) {
        guard let event = event else {
            print("no event\n")
            return
        }
        
        if event.type == UIEventType.remoteControl {
            switch event.subtype {
            case .remoteControlTogglePlayPause:
                print("暂停/播放")
            case .remoteControlPreviousTrack:
                print("上一首")
            case .remoteControlNextTrack:
                print("下一首")
            case .remoteControlPlay:
                print("播放")
                player!.play()
                //设置后台播放显示信息
//                self.setInfoCenterCredentials(playbackState: 1)
            case .remoteControlPause:
                print("暂停")
                player!.pause()
                //后台播放显示信息进度停止
                setInfoCenterCredentials(playbackState: 0)
            default:
                break
            }
        }
    }
    
    
    
    
    @IBAction func playButtonTapped(_ sender: Any) {
        
        //根据rate属性判断当天是否在播放
        
        if player?.rate == 0 {
            player?.play()
            playButton.setTitle("暂停", for: .normal)
        } else {
            player?.pause()
            playButton.setTitle("播放", for: .normal)
            //后台播放显示信息进度停止
            setInfoCenterCredentials(playbackState: 0)
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
        
        //告诉系统接受远程响应事件，并注册成为第一响应者
        UIApplication.shared.beginReceivingRemoteControlEvents()
        self.becomeFirstResponder()
    }
    
    //页面消失时取消歌曲播放结束通知监听
    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self)
        //停止接受远程响应事件
        UIApplication.shared.endReceivingRemoteControlEvents()
        self.resignFirstResponder()
    }
    
    //歌曲播放完毕
    @objc func finishedPlaying(myNotification:NSNotification) {
        print("播放完毕!")
        let stopedPlayerItem = myNotification.object as! AVPlayerItem
        stopedPlayerItem.seek(to: kCMTimeZero, completionHandler: nil)
        playButton.setTitle("播放", for: .normal)
    }
    
    
    //是否能成为第一响应对象
    override var canBecomeFirstResponder: Bool {
        return true
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
