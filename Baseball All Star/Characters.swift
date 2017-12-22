//
//  Characters.swift
//  Baseball All Star
//
//  Created by Vlad verba  on 7/10/17.
//  Copyright © 2017 vladverba. All rights reserved.
//

import Foundation
import SpriteKit

var noPlayersSelected = true

var metstouched = false
var mets = SKSpriteNode()

var giantstouched = false
var giants = SKSpriteNode()

var marlinstouched = false
var marlins = SKSpriteNode()

var blackedtouched = false
var blacked = SKSpriteNode()

var goldtouched = false
var gold = SKSpriteNode()

var americantouched = false
var american = SKSpriteNode()

var player1touched = false
var player1 = SKSpriteNode()

var moneytouched = false
var money = SKSpriteNode()

var fidgettouched = false
var fidget = SKSpriteNode()

var lockmets = SKSpriteNode()
var lockedmets = true

var lockgiants = SKSpriteNode()
var lockedgiants = true

var lockmarlins = SKSpriteNode()
var lockedmarlins = true

var lockblack = SKSpriteNode()
var lockedblack = true

var lockgold = SKSpriteNode()
var lockedgold = true

var lockamerican = SKSpriteNode()
var lockedamerican = true

var lockmoney = SKSpriteNode()
var lockedmoney = true

var lockfidget = SKSpriteNode()
var lockedfidget = true




class Characters: SKScene, SKPhysicsContactDelegate {
    
    var home = SKSpriteNode()
    var unlockAll = SKSpriteNode()

    override func didMove(to view: SKView) {
        
        gameOverBool = false
        
        adNum = 1
        
        mets = SKSpriteNode(imageNamed: "metsball.png")
        mets.position = CGPoint(x: (self.size.width * 0.30) , y: self.size.height * 0.70)
        mets.size = CGSize(width: 40, height: 40)
        mets.zPosition = 2
        mets.name = "mets"
        addChild(mets)
        
        lockmets = SKSpriteNode(imageNamed: "metslock.png")
        lockmets.position = CGPoint(x: (self.size.width * 0.30) , y: self.size.height * 0.70)
        lockmets.size = CGSize(width: 70, height: 70)
        lockmets.zPosition = 4
        lockmets.name = "lockmets"
        if lockedmets == true {
        addChild(lockmets)
        }
        else if lockedmets == false {
        lockmets.removeFromParent()
        }
        
        giants = SKSpriteNode(imageNamed: "giantsball.png")
        giants.position = CGPoint(x: (self.size.width * 0.50) , y: self.size.height * 0.70)
        giants.size = CGSize(width: 40, height: 40)
        giants.zPosition = 2
        giants.name = "giants"
        addChild(giants)
        
        lockgiants = SKSpriteNode(imageNamed: "giantslock.png")
        lockgiants.position = CGPoint(x: (self.size.width * 0.50) , y: self.size.height * 0.70)
        lockgiants.size = CGSize(width: 70, height: 70)
        lockgiants.zPosition = 4
        lockgiants.name = "lockgiants"
        if lockedgiants == true {
            addChild(lockgiants)
        }
        else if lockedgiants == false {
            lockgiants.removeFromParent()
        }
        
        
        marlins = SKSpriteNode(imageNamed: "marlinsball.png")
        marlins.position = CGPoint(x: (self.size.width * 0.70) , y: self.size.height * 0.70)
        marlins.size = CGSize(width: 40, height: 40)
        marlins.zPosition = 2
        marlins.name = "marlins"
        addChild(marlins)
        
        lockmarlins = SKSpriteNode(imageNamed: "marlinslock.png")
        lockmarlins.position = CGPoint(x: (self.size.width * 0.70) , y: self.size.height * 0.70)
        lockmarlins.size = CGSize(width: 70, height: 70)
        lockmarlins.zPosition = 4
        lockmarlins.name = "lockmarlins"
        if lockedmarlins == true {
            addChild(lockmarlins)
        }
        else if lockedmarlins == false {
            lockmarlins.removeFromParent()
        }
        
        blacked = SKSpriteNode(imageNamed: "blackedoutball.png")
        blacked.position = CGPoint(x: (self.size.width * 0.30) , y: self.size.height * 0.50)
        blacked.size = CGSize(width: 40, height: 40)
        blacked.zPosition = 2
        blacked.name = "blacked"
        addChild(blacked)
        
        lockblack = SKSpriteNode(imageNamed: "blackedlock.png")
        lockblack.position = CGPoint(x: (self.size.width * 0.30) , y: self.size.height * 0.50)
        lockblack.size = CGSize(width: 70, height: 70)
        lockblack.zPosition = 4
        lockblack.name = "lockblack"
        if lockedblack == true {
            addChild(lockblack)
        }
        else if lockedblack == false {
            lockblack.removeFromParent()
        }
        
        gold = SKSpriteNode(imageNamed: "goldball.png")
        gold.position = CGPoint(x: (self.size.width * 0.50) , y: self.size.height * 0.50)
        gold.size = CGSize(width: 40, height: 40)
        gold.zPosition = 2
        gold.name = "gold"
        addChild(gold)
        
        lockgold = SKSpriteNode(imageNamed: "goldlock.png")
        lockgold.position = CGPoint(x: (self.size.width * 0.50) , y: self.size.height * 0.50)
        lockgold.size = CGSize(width: 70, height: 70)
        lockgold.zPosition = 4
        lockgold.name = "lockblack"
        if lockedgold == true {
            addChild(lockgold)
        }
        else if lockedgold == false {
            lockgold.removeFromParent()
        }
        
        american = SKSpriteNode(imageNamed: "americanball2.png")
        american.position = CGPoint(x: (self.size.width * 0.70) , y: self.size.height * 0.50)
        american.size = CGSize(width: 40, height: 40)
        american.zPosition = 2
        american.name = "american"
        addChild(american)
        
        lockamerican = SKSpriteNode(imageNamed: "americanlock.png")
        lockamerican.position = CGPoint(x: (self.size.width * 0.70) , y: self.size.height * 0.50)
        lockamerican.size = CGSize(width: 70, height: 70)
        lockamerican.zPosition = 4
        lockamerican.name = "lockamerican"
        if lockedamerican == true {
            addChild(lockamerican)
        }
        else if lockedamerican == false {
            lockamerican.removeFromParent()
        }
        
        player1 = SKSpriteNode(imageNamed: "baseballplayer.png")
        player1.position = CGPoint(x: (self.size.width * 0.30) , y: self.size.height * 0.30)
        player1.size = CGSize(width: 40, height: 40)
        player1.zPosition = 2
        player1.name = "player1"
        addChild(player1)
        
        money = SKSpriteNode(imageNamed: "moneyball.png")
        money.position = CGPoint(x: (self.size.width * 0.50) , y: self.size.height * 0.30)
        money.size = CGSize(width: 40, height: 40)
        money.zPosition = 2
        money.name = "money"
        addChild(money)
        
        lockmoney = SKSpriteNode(imageNamed: "moneylock.png")
        lockmoney.position = CGPoint(x: (self.size.width * 0.50) , y: self.size.height * 0.30)
        lockmoney.size = CGSize(width: 70, height: 70)
        lockmoney.zPosition = 4
        lockmoney.name = "lockmoney"
        if lockedmoney == true {
            addChild(lockmoney)
        }
        else if lockedmoney == false {
            lockmoney.removeFromParent()
        }
        
        fidget = SKSpriteNode(imageNamed: "fidgetspinnerball.png")
        fidget.position = CGPoint(x: (self.size.width * 0.70) , y: self.size.height * 0.30)
        fidget.size = CGSize(width: 40, height: 40)
        fidget.zPosition = 2
        fidget.name = "fidget"
        addChild(fidget)
        
        lockfidget = SKSpriteNode(imageNamed: "fidgetlock.png")
        lockfidget.position = CGPoint(x: (self.size.width * 0.70) , y: self.size.height * 0.30)
        lockfidget.size = CGSize(width: 70, height: 70)
        lockfidget.zPosition = 4
        lockfidget.name = "lockfidget"
        if lockedfidget == true {
            addChild(lockfidget)
        }
        else if lockedfidget == false {
            lockfidget.removeFromParent()
        }
        
        home = SKSpriteNode(imageNamed: "home.png")
        home.size = CGSize(width: 100, height: 33)
        home.position = CGPoint(x: self.size.width * 0.50, y: self.size.height * 0.85)
        home.name = "home"
        addChild(home)
        

        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    
        for touch: AnyObject in touches {
            
            let pointOfTouch  = touch.location(in: self)
            let tappedNode = atPoint(pointOfTouch)
            let tappedNodeName = tappedNode.name
            
            if tappedNodeName == "home" {
                let sceneToMoveTo = MainMenuScene(size: self.size)
                sceneToMoveTo.scaleMode = self.scaleMode
                let sceneTransition = SKTransition.fade(withDuration: 0.2)
                self.view?.presentScene(sceneToMoveTo, transition: sceneTransition)
            }
            
            if tappedNodeName == "mets" {
                
                metstouched = true
                
                giantstouched = false
                marlinstouched = false
                blackedtouched = false
                goldtouched = false
                americantouched = false
                player1touched = false
                moneytouched = false
                fidgettouched = false
                
                let sceneToMoveTo = MainMenuScene(size: self.size)
                sceneToMoveTo.scaleMode = self.scaleMode
                let sceneTransition = SKTransition.fade(with: UIColor.green, duration: 0.5)
                self.view?.presentScene(sceneToMoveTo, transition: sceneTransition)
                


            }
            
            if tappedNodeName == "giants" {
                
                giantstouched = true
                
                metstouched = false
                marlinstouched = false
                blackedtouched = false
                goldtouched = false
                americantouched = false
                player1touched = false
                moneytouched = false
                fidgettouched = false
                
                let sceneToMoveTo = MainMenuScene(size: self.size)
                sceneToMoveTo.scaleMode = self.scaleMode
                let sceneTransition = SKTransition.fade(with: UIColor.green, duration: 0.5)
                self.view?.presentScene(sceneToMoveTo, transition: sceneTransition)
                
            }
            
            if tappedNodeName == "marlins" {
                
                marlinstouched = true
                
                giantstouched = false
                metstouched = false
                blackedtouched = false
                goldtouched = false
                americantouched = false
                player1touched = false
                moneytouched = false
                fidgettouched = false
                
                let sceneToMoveTo = MainMenuScene(size: self.size)
                sceneToMoveTo.scaleMode = self.scaleMode
                let sceneTransition = SKTransition.fade(with: UIColor.green, duration: 0.5)
                self.view?.presentScene(sceneToMoveTo, transition: sceneTransition)
                
            }
            
            if tappedNodeName == "blacked" {
                
                blackedtouched = true
                
                giantstouched = false
                marlinstouched = false
                metstouched = false
                goldtouched = false
                americantouched = false
                player1touched = false
                moneytouched = false
                fidgettouched = false
                
                let sceneToMoveTo = MainMenuScene(size: self.size)
                sceneToMoveTo.scaleMode = self.scaleMode
                let sceneTransition = SKTransition.fade(with: UIColor.green, duration: 0.5)
                self.view?.presentScene(sceneToMoveTo, transition: sceneTransition)
                
                
                
            }
            
            if tappedNodeName == "gold" {
                
                goldtouched = true
                
                giantstouched = false
                marlinstouched = false
                blackedtouched = false
                metstouched = false
                americantouched = false
                player1touched = false
                moneytouched = false
                fidgettouched = false
                
                let sceneToMoveTo = MainMenuScene(size: self.size)
                sceneToMoveTo.scaleMode = self.scaleMode
                let sceneTransition = SKTransition.fade(with: UIColor.green, duration: 0.5)
                self.view?.presentScene(sceneToMoveTo, transition: sceneTransition)
                
            }
            
            if tappedNodeName == "american" {
                
                americantouched = true
                
                giantstouched = false
                marlinstouched = false
                blackedtouched = false
                goldtouched = false
                metstouched = false
                player1touched = false
                moneytouched = false
                fidgettouched = false
                
                let sceneToMoveTo = MainMenuScene(size: self.size)
                sceneToMoveTo.scaleMode = self.scaleMode
                let sceneTransition = SKTransition.fade(with: UIColor.green, duration: 0.5)
                self.view?.presentScene(sceneToMoveTo, transition: sceneTransition)
                
            }
            
            if tappedNodeName == "player1" {
                
                player1touched = true
                
                giantstouched = false
                marlinstouched = false
                blackedtouched = false
                goldtouched = false
                americantouched = false
                metstouched = false
                moneytouched = false
                fidgettouched = false
                
                let sceneToMoveTo = MainMenuScene(size: self.size)
                sceneToMoveTo.scaleMode = self.scaleMode
                let sceneTransition = SKTransition.fade(with: UIColor.green, duration: 0.5)
                self.view?.presentScene(sceneToMoveTo, transition: sceneTransition)
            }
            
            if tappedNodeName == "money" {
                
                moneytouched = true
                
                giantstouched = false
                marlinstouched = false
                blackedtouched = false
                goldtouched = false
                americantouched = false
                player1touched = false
                metstouched = false
                fidgettouched = false
                
                let sceneToMoveTo = MainMenuScene(size: self.size)
                sceneToMoveTo.scaleMode = self.scaleMode
                let sceneTransition = SKTransition.fade(with: UIColor.green, duration: 0.5)
                self.view?.presentScene(sceneToMoveTo, transition: sceneTransition)
                
            }
            
            if tappedNodeName == "fidget" {
                
                fidgettouched = true
                
                giantstouched = false
                marlinstouched = false
                blackedtouched = false
                goldtouched = false
                americantouched = false
                player1touched = false
                metstouched = false
                metstouched = false
                
                let sceneToMoveTo = MainMenuScene(size: self.size)
                sceneToMoveTo.scaleMode = self.scaleMode
                let sceneTransition = SKTransition.fade(with: UIColor.green, duration: 0.5)
                self.view?.presentScene(sceneToMoveTo, transition: sceneTransition)
                
            }

            
            
        }

    
    }
    
    


}
