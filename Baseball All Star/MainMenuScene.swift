//
//  MainMenuScene.swift
//  Gravity Swap
//
//  Created by Vlad verba  on 6/22/17.
//  Copyright © 2017 vladverba. All rights reserved.
//

import Foundation
import SpriteKit
import UserNotifications

let particleEmitter = CAEmitterLayer()

class MainMenuScene: SKScene, SKPhysicsContactDelegate{
    
    
    
    var playButton = SKSpriteNode()
    var taptocontinue = SKSpriteNode()
    var watch2Revive = SKSpriteNode()
    
    var rateUs = SKSpriteNode()
    var ShareUs = SKSpriteNode()
    var likeUs = SKSpriteNode()
    var unlockPlayers = SKSpriteNode()
    
    var logo = SKSpriteNode()
    
    let whistle = SKAction.playSoundFileNamed("baseballwhistle.wav", waitForCompletion: true)
    
    override func didMove(to view: SKView) {
        
        displayNotifs()
        displayNotifs2()
        
    if (gameOverBool == true){
            
            run(whistle)

        
        var randomImageNumber = arc4random()%4
        if (randomImageNumber == 1) {

        watch2Revive = SKSpriteNode(imageNamed: "watchtorevive.png")
            watch2Revive.size = CGSize(width: 75, height: 75)
            watch2Revive.position = CGPoint(x: self.size.width * 0.80, y: self.size.height * 0.55)
            watch2Revive.name = "watchforcoins"
            addChild(watch2Revive)
        }
            
            let pulseUp = SKAction.scale(to: 1.2, duration: 0.3)
            let pulseDown = SKAction.scale(to: 0.8, duration: 0.3)
            
            let sequenceResize = SKAction.sequence([pulseUp, pulseDown])
            
            let runResize = SKAction.repeatForever(sequenceResize)
            
            watch2Revive.run(runResize)
        
    
        }
        
        let logoLabel = SKLabelNode(fontNamed: "Krinkes Regular PERSONAL USE")
        logoLabel.text = "Baseball All-Star0"
        logoLabel.fontSize = 55
        logoLabel.position = CGPoint(x: self.size.width * 0.50, y: self.size.height * 0.85)
        logoLabel.fontColor = SKColor.white
        logoLabel.zPosition = 1
        self.addChild(logoLabel)
        
        
        playButton = SKSpriteNode(imageNamed: "playbaseball.png")
        playButton.size = CGSize(width: 100, height: 100)
        playButton.position = CGPoint(x: self.size.width / 2, y: self.size.height / 2)
        playButton.name = "play"
        addChild(playButton)
        
        rateUs = SKSpriteNode(imageNamed: "rateBaseball.png")
        rateUs.size = CGSize(width: 50, height: 50)
        rateUs.position = CGPoint(x: self.size.width * 0.30, y: self.size.height * 0.17)
        rateUs.name = "rateus"
        addChild(rateUs)
        
        ShareUs = SKSpriteNode(imageNamed: "shareBaseball.png")
        ShareUs.size = CGSize(width: 50, height: 50)
        ShareUs.position = CGPoint(x: self.size.width * 0.70, y: self.size.height * 0.17)
        ShareUs.name = "shareus"
        addChild(ShareUs)
        
        likeUs = SKSpriteNode(imageNamed: "likeBaseball.png")
        likeUs.size = CGSize(width: 50, height: 50)
        likeUs.position = CGPoint(x: self.size.width * 0.50, y: self.size.height * 0.17)
        likeUs.name = "likeUs"
        addChild(likeUs)
        
        unlockPlayers = SKSpriteNode(imageNamed: "unlock.png")
        unlockPlayers.size = CGSize(width: 100, height: 38)
        unlockPlayers.position = CGPoint(x: self.size.width * 0.50, y: self.size.height * 0.30)
        unlockPlayers.name = "unlock"
        addChild(unlockPlayers)
        
        
        // what score did you get?
        let finalScoreLabel = SKLabelNode(fontNamed: "Arial Rounded MT Bold")
        finalScoreLabel.text = "Score"
        finalScoreLabel.fontSize = 20
        finalScoreLabel.position = CGPoint(x: self.size.width * 0.30, y: self.size.height * 0.65)
        finalScoreLabel.fontColor = SKColor.white
        finalScoreLabel.zPosition = 1
        self.addChild(finalScoreLabel)
        
        // what score did you get?
        let finalScoreNum = SKLabelNode(fontNamed: "Arial Rounded MT Bold")
        finalScoreNum.text = "\(numPoints)"
        finalScoreNum.fontSize = 40
        finalScoreNum.position = CGPoint(x: self.size.width * 0.30, y: self.size.height * 0.68)
        finalScoreNum.fontColor = SKColor.white
        finalScoreNum.zPosition = 1
        self.addChild(finalScoreNum)
        
        // high score
        let defaults = UserDefaults()
        var highScoreNumber = defaults.integer(forKey: "highScoreSaved")
        
        if numPoints > highScoreNumber {
            createParticles()
            highScoreNumber = numPoints
            defaults.set(highScoreNumber, forKey: "highScoreSaved")
            
        }
        
        // high score label
        let highScoreLabel = SKLabelNode(fontNamed: "Arial Rounded MT Bold")
        highScoreLabel.text = "Best"
        highScoreLabel.fontSize = 20
        highScoreLabel.position = CGPoint(x: self.size.width * 0.70, y: self.size.height * 0.65)
        highScoreLabel.fontColor = SKColor.white
        highScoreLabel.zPosition = 1
        self.addChild(highScoreLabel)
        
        // high score label
        let highScoreNum = SKLabelNode(fontNamed: "Arial Rounded MT Bold")
        highScoreNum.text = "\(highScoreNumber)"
        highScoreNum.fontSize = 40
        highScoreNum.position = CGPoint(x: self.size.width * 0.70, y: self.size.height * 0.68)
        highScoreNum.fontColor = SKColor.white
        highScoreNum.zPosition = 1
        self.addChild(highScoreNum)
        
        if (adNum % 3 == 0){
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "ShowInterAd"), object: nil)
        }
        
        let defaults1 = UserDefaults()
        var coinsAmount = defaults1.integer(forKey: "coinsAmount")
        coinsAmount += numCoins
        defaults.set(coinsAmount, forKey: "coinsAmount")
        let coinsLabel = SKLabelNode(fontNamed: "Arial Rounded MT Bold")
        coinsLabel.text = "Coins: \(coinsAmount)"
        coinsLabel.fontSize = 15
        coinsLabel.position = CGPoint(x: self.size.width * 0.85, y: self.size.height * 0.95)
        coinsLabel.fontColor = SKColor.white
        coinsLabel.zPosition = 1
        self.addChild(coinsLabel)
        
        if (coinsAmount >= 100){

            lockedmets = false
            
        }
        
        if (coinsAmount >= 150){
            
            lockedgiants = false
            
        }
        
        if (coinsAmount >= 200){
            
            lockedmarlins = false
            
        }
        
        if (coinsAmount >= 300){
            
            lockedblack = false
            
        }
        
        if (coinsAmount >= 400){
            
            lockedgold = false
            
        }
        
        if (coinsAmount >= 500){
            
            lockedamerican = false
            
        }
        
        if (coinsAmount >= 700){
            
            lockedmoney = false
            
        }
        
        
        if (coinsAmount >= 1000){
            
            lockedfidget = false
            
        }
    
        
    }
    
    
    
    func createParticles() {
        
        particleEmitter.emitterPosition = CGPoint(x: (view?.center.x)!, y: -96)
        particleEmitter.emitterShape = kCAEmitterLayerLine
        particleEmitter.emitterSize = CGSize(width: (view?.frame.size.width)!, height: 1)
        
        let red = makeEmitterCell(color: UIColor.red)
        let green = makeEmitterCell(color: UIColor.green)
        let blue = makeEmitterCell(color: UIColor.blue)
        
        particleEmitter.emitterCells = [red, green, blue]
        
        view?.layer.addSublayer(particleEmitter)
    }
    
    func makeEmitterCell(color: UIColor) -> CAEmitterCell {
        let cell = CAEmitterCell()
        cell.birthRate = 3
        cell.lifetime = 7.0
        cell.lifetimeRange = 0
        cell.color = color.cgColor
        cell.velocity = 200
        cell.velocityRange = 50
        cell.emissionLongitude = CGFloat.pi
        cell.emissionRange = CGFloat.pi / 4
        cell.spin = 2
        cell.spinRange = 3
        cell.scaleRange = 0.5
        cell.scaleSpeed = -0.05
        
        cell.contents = UIImage(named: "Confetti.png")?.cgImage
        return cell
    }
    
    func displayNotifs() {
        
        if #available(iOS 10.0, *) {
            UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge], completionHandler: {didAllow, error in})
        } else {
            // Fallback on earlier versions
        }
        
        if #available(iOS 10.0, *) {
            let content = UNMutableNotificationContent()
            let randomScoreGameOver = arc4random_uniform(83) + 31
            content.title = "Today's High Score 😱"
            content.subtitle = "Someone hit \(randomScoreGameOver) in Baseball All-Star today."
            content.body = "Can you beat that?"
            content.badge = 1
            
            // change repeat to true
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 86400, repeats: true)
            
            let request = UNNotificationRequest(identifier: "timerDone", content: content, trigger: trigger)
            
            UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
            
        } else {
            // Fallback on earlier versions
        }
        
    }
    
    func displayNotifs2() {
        
        if #available(iOS 10.0, *) {
            UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge], completionHandler: {didAllow, error in})
        } else {
            // Fallback on earlier versions
        }
        
        if #available(iOS 10.0, *) {
            let content = UNMutableNotificationContent()
            content.title = "GET MORE COINS 🙀"
            content.subtitle = "Come play today to collect more coins 💰"
            content.body = "Unlock all the characters 💪"
            content.badge = 1
            
            // change repeat to true
            let trigger1 = UNTimeIntervalNotificationTrigger(timeInterval: 86400/1.5, repeats: true)
            
            let request1 = UNNotificationRequest(identifier: "timerDone1", content: content, trigger: trigger1)
            
            UNUserNotificationCenter.current().add(request1, withCompletionHandler: nil)
            
        } else {
            // Fallback on earlier versions
        }
        
    }


    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        
        for touch: AnyObject in touches {
            
            let pointOfTouch  = touch.location(in: self)
            let tappedNode = atPoint(pointOfTouch)
            let tappedNodeName = tappedNode.name
            
            if tappedNodeName == "play" {
                
                videoTapped = false
                
                let sceneToMoveTo = GameScene(size: self.size)
                sceneToMoveTo.scaleMode = self.scaleMode
                let sceneTransition = SKTransition.fade(withDuration: 0.2)
                self.view?.presentScene(sceneToMoveTo, transition: sceneTransition)
            }
            
            
            if tappedNodeName == "unlock" {
                
                let sceneToMoveTo = Characters(size: self.size)
                sceneToMoveTo.scaleMode = self.scaleMode
                let sceneTransition = SKTransition.fade(withDuration: 0.2)
                self.view?.presentScene(sceneToMoveTo, transition: sceneTransition)

                
            }
            
            if tappedNodeName == "shareus" {
                
                let textToShare = "Check out Baseball All Star on the App Store. It's free!"
                
                let objectsToShare = [textToShare]
                let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
                
                activityVC.excludedActivityTypes = [UIActivityType.airDrop, UIActivityType.addToReadingList]
                
                let currentViewController:UIViewController=UIApplication.shared.keyWindow!.rootViewController!
                
                currentViewController.present(activityVC, animated: true, completion: nil)
                
            }
            
            if tappedNodeName == "rateus" {
                
                UIApplication.shared.openURL(NSURL(string: "https://itunes.apple.com/us/app/cupid-shuffle/id1201329756?mt=8")! as URL)
                
            }
            
            if tappedNodeName == "likeUs"{
                
                UIApplication.shared.openURL(NSURL(string: "https://www.instagram.com/taptapplay/")! as URL)
            }
            
            if tappedNodeName == "watchforcoins"{
                
            _ = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(MainMenuScene.addContinue), userInfo: nil, repeats: true)



                watch2Revive.removeFromParent()
                
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "ShowInterAd"), object: nil)

            
                
                
                
                }
            
            if tappedNodeName == "continuenow"{
                

                let sceneToMoveTo = GameScene(size: self.size)
                sceneToMoveTo.scaleMode = self.scaleMode
                let sceneTransition = SKTransition.fade(withDuration: 0.2)
                self.view?.presentScene(sceneToMoveTo, transition: sceneTransition)
        
                
            }
            
            if tappedNodeName == "removeAds"{
                
                
            }
            
        }
    }
    
    func addContinue() {
        
        videoTapped = true
        
        taptocontinue = SKSpriteNode(imageNamed: "taptocontinue.png")
        taptocontinue.size = CGSize(width: 100, height: 100)
        taptocontinue.position = CGPoint(x: self.size.width / 2, y: self.size.height / 2)
        taptocontinue.zPosition = 7
        taptocontinue.name = "continuenow"
        addChild(taptocontinue)
    }
    
    

    
    
}
