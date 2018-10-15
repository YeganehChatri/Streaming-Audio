//
//  ViewController.swift
//  streaming Audio2
//
//  Created by yeganeh on 10/9/18.
//  Copyright © 2018 yeganeh. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    //Class variables
    
    //all of the outlets
    var player:AVPlayer?
    var playerItem:AVPlayerItem?
    var playerLayer:AVPlayerLayer?
    var playButton:UIButton?
    var nextButton:UIButton?
    var prevButton:UIButton?
    var upButton:UIButton?
    var downButton:UIButton?
    var stopButton:UIButton?
    var durLabel:UILabel = UILabel();
    var curLabel:UILabel = UILabel();
    var songLabel:UILabel = UILabel();
    
    var list1:UIButton?
    var list2:UIButton?
    var list3:UIButton?
    
    var playbackSlider:UISlider?
    //Current song from list of songs
    var listNum = 1;
    //LIST OF Audio Files
    var listOfSongs: [String] = ["list of song"]
    
    var currentSong = 0;
    var currentList = 0;
    
    let startURL = "server address"
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func viewWillAppear(_ animated: Bool) {
        //ALL THE OUTLETS --> Buttons and Labels - placing on the screen
        
        playButton = UIButton(type: UIButtonType.system) as UIButton
        playButton!.frame = CGRect(x: 25, y: 60, width: 110, height: 35)
        playButton!.backgroundColor = UIColor.lightGray
        playButton!.setTitle("Play", for: UIControlState.normal)
        // playButton!.setImage(UIImage(named: "play.png"), for: UIControlState.normal)
        playButton!.tintColor = UIColor.black
        playButton!.addTarget(self, action: #selector(ViewController.playButtonTapped(_:)), for: .touchUpInside)
        self.view.addSubview(playButton!)
        
        prevButton = UIButton(type: UIButtonType.system) as UIButton
        prevButton!.frame = CGRect(x: 25, y: 100, width: 50, height: 25)
        prevButton!.backgroundColor = UIColor.lightGray
        prevButton!.setTitle("<<", for: UIControlState.normal)
        prevButton!.tintColor = UIColor.black
        prevButton!.addTarget(self, action: #selector(ViewController.prevButtonTapped(_:)), for: .touchUpInside)
        self.view.addSubview(prevButton!)
        
        nextButton = UIButton(type: UIButtonType.system) as UIButton
        nextButton!.frame = CGRect(x: 85, y: 100, width: 50, height: 25)
        nextButton!.backgroundColor = UIColor.lightGray
        nextButton!.setTitle(">>", for: UIControlState.normal)
        nextButton!.tintColor = UIColor.black
        nextButton!.addTarget(self, action: #selector(ViewController.nextButtonTapped(_:)), for: .touchUpInside)
        self.view.addSubview(nextButton!)
        
        stopButton = UIButton(type: UIButtonType.system) as UIButton
        stopButton!.frame = CGRect(x: 145, y: 100, width: 50, height: 25)
        stopButton!.backgroundColor = UIColor.lightGray
        stopButton!.setTitle("STOP", for: UIControlState.normal)
        stopButton!.tintColor = UIColor.black
        stopButton!.addTarget(self, action: #selector(ViewController.stopButtonTapped(_:)), for: .touchUpInside)
        self.view.addSubview(stopButton!)
        
        durLabel.frame = CGRect(x: 190, y: 190, width: 100, height: 25)
        //  durLabel.backgroundColor = UIColor.orange
        durLabel.textColor = UIColor.black
        durLabel.textAlignment = NSTextAlignment.center
        durLabel.text = "00:0"
        self.view.addSubview(durLabel)
        
        curLabel.frame = CGRect(x: 25, y: 190, width: 100, height: 25)
        // curLabel.backgroundColor = UIColor.orange
        curLabel.textColor = UIColor.black
        curLabel.textAlignment = NSTextAlignment.center
        curLabel.text = "00:0"
        self.view.addSubview(curLabel)
        
        songLabel.frame = CGRect(x: 30, y: 30, width: 200, height: 25)
        // songLabel.backgroundColor = UIColor.orange
        songLabel.textColor = UIColor.black
        songLabel.textAlignment = NSTextAlignment.left
        songLabel.text = "..."
        self.view.addSubview(songLabel)
        
        //LIST OF SONGS +++++++++++++++++++++++++++++++++++++++++++++++
        list1 = UIButton(type: UIButtonType.system) as UIButton
        list1!.frame = CGRect(x: 30, y: 300, width: 200, height: 25)
        list1!.backgroundColor = UIColor.orange
        list1!.tintColor = UIColor.black
        list1!.setTitle(listOfSongs[0], for: UIControlState.normal)
        list1!.addTarget(self, action: #selector(ViewController.list1Tapped(_:)), for: .touchUpInside)
        self.view.addSubview( list1!)
        
        list2 = UIButton(type: UIButtonType.system) as UIButton
        list2!.frame = CGRect(x: 30, y: 327, width: 200, height: 25)
        list2!.backgroundColor = UIColor.gray
        list2!.tintColor = UIColor.black
        list2!.setTitle(listOfSongs[1], for: UIControlState.normal)
        list2!.addTarget(self, action: #selector(ViewController.list2Tapped(_:)), for: .touchUpInside)
        self.view.addSubview(list2!)
        
        list3 = UIButton(type: UIButtonType.system) as UIButton
        list3!.frame = CGRect(x: 30, y: 354, width: 200, height: 25)
        list3!.backgroundColor = UIColor.gray
        list3!.tintColor = UIColor.black
        list3!.setTitle(listOfSongs[2], for: UIControlState.normal)
        list3!.addTarget(self, action: #selector(ViewController.list3Tapped(_:)), for: .touchUpInside)
        self.view.addSubview(list3!)
        
        //move List UP and Down
        
        upButton = UIButton(type: UIButtonType.system) as UIButton
        upButton!.frame = CGRect(x: 25, y: 270, width: 50, height: 20)
        upButton!.backgroundColor = UIColor.lightGray
        upButton!.setTitle("up", for: UIControlState.normal)
        upButton!.tintColor = UIColor.black
        upButton!.addTarget(self, action: #selector(ViewController.upButtonTapped(_:)), for: .touchUpInside)
        self.view.addSubview(upButton!)
        
        downButton = UIButton(type: UIButtonType.system) as UIButton
        downButton!.frame = CGRect(x: 25, y: 390, width: 50, height: 20)
        downButton!.backgroundColor = UIColor.lightGray
        downButton!.setTitle("down", for: UIControlState.normal)
        downButton!.tintColor = UIColor.black
        downButton!.addTarget(self, action: #selector(ViewController.downButtonTapped(_:)), for: .touchUpInside)
        self.view.addSubview(downButton!)
        
        
        
        // Add playback slider
        
        playbackSlider = UISlider(frame:CGRect(x: 10, y: 170, width: 300, height: 20))
        playbackSlider!.minimumValue = 0
        
        setPlayer();//setup avplayer avPlayerItem --> objects used to play audio files
        
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /* Function called when sliders is adjusted manually.
     */
    @objc func playbackSliderValueChanged(_ playbackSlider:UISlider)
    {
        
        let seconds : Int64 = Int64(playbackSlider.value)
        let targetTime:CMTime = CMTimeMake(seconds, 1)
        
        player!.seek(to: targetTime)
        
        if player!.rate == 0
        {
            player?.play()
        }
    }
    
    
    //setup avplayer avPlayerItem --> objects used to play audio files
    func setPlayer(){
        
        let url = URL(string: startURL + listOfSongs[currentSong])
        let playerItem:AVPlayerItem = AVPlayerItem(url: url!)
        player = AVPlayer(playerItem: playerItem)
        
        
        playerLayer=AVPlayerLayer(player: player!)
        playerLayer?.frame=CGRect(x: 0, y: 0, width: 10, height: 50)
        self.view.layer.addSublayer(playerLayer!)
        
        let duration : CMTime = playerItem.asset.duration
        let seconds : Float64 = CMTimeGetSeconds(duration)
        
        let mySecs = Int(seconds) % 60
        let myMins = Int(seconds / 60)
        
        let myTimes = String(myMins) + ":" + String(mySecs);
        durLabel.text = myTimes;
        
        
        playbackSlider!.maximumValue = Float(seconds)
        playbackSlider!.isContinuous = false
        playbackSlider!.tintColor = UIColor.green
        
        playbackSlider?.addTarget(self, action: #selector(ViewController.playbackSliderValueChanged(_:)), for: .valueChanged)
        self.view.addSubview(playbackSlider!)
        
        //subroutine used to keep track of current location of time in audio file
        player!.addPeriodicTimeObserver(forInterval: CMTimeMakeWithSeconds(1, 1), queue: DispatchQueue.main) { (CMTime) -> Void in
            if self.player!.currentItem?.status == .readyToPlay {
                let time : Float64 = CMTimeGetSeconds(self.player!.currentTime());
                
                //comment out if you don't want continous play
                if(time == seconds && self.currentSong != self.listOfSongs.count-1){
                    self.contPlay()
                }
                
                let mySecs2 = Int(time) % 60
                
                if(mySecs2 == 1){//show title of song after 1 second
                    self.songLabel.text = self.listOfSongs[self.currentSong];
                }
                let myMins2 = Int(time / 60)
                
                let myTimes2 = String(myMins2) + ":" + String(mySecs2);
                self.curLabel.text = myTimes2;//current time of audio track
                
                
                self.playbackSlider!.value = Float ( time );
            }
        }
    }
    
    
    
    //play button clicked --> song plays if it was paused and vicaversa
    @objc func playButtonTapped(_ sender:UIButton)
    {
        if player?.rate == 0
        {
            player!.play()
            //  playButton!.setImage(UIImage(named: "29-circle-pause.png"), for: UIControlState.normal)
            playButton!.setTitle("Pause", for: UIControlState.normal)
        } else {
            player!.pause()
            // playButton!.setImage(UIImage(named: "play.png"), for: UIControlState.normal)
            
            playButton!.setTitle("Play", for: UIControlState.normal)
        }
    }
    
    
    
    //next button clicked - go to next song in list and play
    @objc func nextButtonTapped(_ sender:UIButton)
    {
        if(currentSong < listOfSongs.count - 1){
            currentSong = currentSong + 1;
            player!.pause()
            player = nil
            
            listNum = listNum + 1;//keep track of which song is being played in list
            if(listNum > 3){
                listNum = 1;
                currentList = currentList + 3;
                showSongs()
            } else {
                getListNum()
            }
            
            
            setPlayer();
            if player?.rate == 0
            {
                songLabel.text = "Loading...";//NOT WORKING
                player!.play()
                playButton!.setTitle("Pause", for: UIControlState.normal)
                
            }
            
        }
    }
    
    //same as next button, but in reverse :)
    @objc func prevButtonTapped(_ sender:UIButton)
    {
        if(currentSong > 0){
            currentSong = currentSong - 1;
            player!.pause()
            player = nil
            
            listNum = listNum - 1;
            if(listNum < 1){
                listNum = 3;
                currentList = currentList - 3;
                if(currentList < 0){
                    currentList = 0;
                }
                showSongs()
            } else {
                getListNum()
            }
            
            
            
            
            setPlayer();
            if player?.rate == 0
            {
                player!.play()
                playButton!.setTitle("Pause", for: UIControlState.normal)
            }
        }
    }
    
    //stops current song and sliders goes back to zero position
    @objc func stopButtonTapped(_ sender:UIButton)
    {
        if player?.rate == 0
        {
            
        } else {
            player!.pause()
            playButton!.setTitle("Play", for: UIControlState.normal)
        }
        
        
        player?.seek(to: CMTimeMake(0, 1))
        
        
    }
    
    
    //plays next song automatically when previous song finishes
    func contPlay(){
        
        if(currentSong < listOfSongs.count - 1){
            currentSong = currentSong + 1;
            listNum = listNum + 1;
            if(listNum > 3){
                listNum = 1;
            }
            getListNum()
            if(currentSong > currentList + 2){
                currentList = currentList + 3;
                showSongs()
                
            }
            player!.pause()
            player = nil
            
            setPlayer();
            if player?.rate == 0
            {
                player!.play()
                playButton!.setTitle("Pause", for: UIControlState.normal)
            }
            
        }
    }
    
    
    //moves the list
    @objc func upButtonTapped(_ sender:UIButton)
    {
        currentList = currentList - 3;
        if(currentList < 0){
            currentList = 0;
        }
        showSongs()
    }
    
    @objc func downButtonTapped(_ sender:UIButton)
    {
        
        currentList = currentList + 3;
        
        
        
        showSongs()
        
    } // end of down method
    
    //sets background colors and currentSong to be played when down or up button is pressed
    func showSongs(){
        if(currentList < listOfSongs.count){
            list1!.setTitle(listOfSongs[currentList], for: UIControlState.normal)
        }else{
            list1!.setTitle(" ", for: UIControlState.normal)
        }
        
        if(currentList + 1 < listOfSongs.count){
            list2!.setTitle(listOfSongs[currentList + 1], for: UIControlState.normal)
        } else {
            list2!.setTitle(" ", for: UIControlState.normal)
        }
        
        
        if(currentList + 2 < listOfSongs.count){
            list3!.setTitle(listOfSongs[currentList + 2], for: UIControlState.normal)
        } else {
            list3!.setTitle(" ", for: UIControlState.normal)
        }
        
        getListNum()
    }//end of show songs
    
    //3 list tapped methods
    @objc func list1Tapped(_ sender:UIButton)
    {
        
        if(currentList < listOfSongs.count){
            listNum = 1;
            currentSong = currentList;
            getListNum()
            
            playOn()
        }
        
        
    }
    
    @objc func list2Tapped(_ sender:UIButton)
    {
        
        
        
        if(currentList + 1 < listOfSongs.count){
            currentSong = currentList + 1;
            listNum = 2;
            getListNum()
            playOn()
        }
        
    }
    
    @objc func list3Tapped(_ sender:UIButton)
    {
        if(currentList + 2 < listOfSongs.count){
            currentSong = currentList + 2;
            listNum = 3;
            getListNum()
            playOn()
        }
        
        
    }//end of list3 tapped
    
    func playOn(){//plays song when song selected from list (slightly different then play button)
        player!.pause()
        player = nil
        
        
        
        
        setPlayer();
        if player?.rate == 0
        {
            player!.play()
            playButton!.setTitle("Pause", for: UIControlState.normal)
        }
    }
    
    
    // determines which song is currently being played and hightlights background
    
    func getListNum(){
        list1!.backgroundColor = UIColor.gray
        list2!.backgroundColor = UIColor.gray
        list3!.backgroundColor = UIColor.gray
        
        if(currentSong > currentList + 2 || currentSong < currentList){
            listNum = 0;
            
        }
        
        if(currentSong == currentList){
            listNum = 1
        }
        
        if(currentSong == currentList + 1){
            listNum = 2
        }
        
        if(currentSong == currentList + 2){
            listNum = 3
        }
        
        if(listNum == 1){
            list1!.backgroundColor = UIColor.orange
        }
        
        if(listNum == 2){
            list2!.backgroundColor = UIColor.orange
        }
        
        if(listNum == 3){
            list3!.backgroundColor = UIColor.orange
        }
        
    }
    
    


}

