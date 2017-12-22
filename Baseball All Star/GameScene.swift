//
//  GameScene.swift
//  Gravity Swap
//
//  Created by Vlad verba  on 6/11/17.
//  Copyright © 2017 vladverba. All rights reserved.
//


// brown hex: #a54511
import SpriteKit
import GameplayKit


enum BodyType: UInt32 {
    case player = 1
    case floor = 2
    case enemy = 4
    case ledge = 8
    case coin = 16
}

var numPoints = 0
var numCoins = 0
var gameOverBool = false
var adNum = 1
var videoTapped = false

var player = SKSpriteNode()



class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var groundBottom = SKSpriteNode()
    var groundTop = SKSpriteNode()
    var enemy1 = SKSpriteNode()
    var enemy2 = SKSpriteNode()
    var enemy3 = SKSpriteNode()
    var enemy4 = SKSpriteNode()
    var glove1 = SKSpriteNode()
    var glove2 = SKSpriteNode()
    var ledge = SKSpriteNode()
    var coin = SKSpriteNode()
    var coin2 = SKSpriteNode()
    
    var pos = 1
    
    let points = SKLabelNode(text: "0")
    let coinz = SKLabelNode(text: "0")
    
    let thud = SKAction.playSoundFileNamed("switchsides.wav", waitForCompletion: false)
    var backgroundMusic: SKAudioNode!

    let ping = SKAction.playSoundFileNamed("ping.wav", waitForCompletion: true)

    var duration = 1.8
    
    override func didMove(to view: SKView) {
        
        particleEmitter.removeFromSuperlayer()

        if let musicURL = Bundle.main.url(forResource: "JuJu Background", withExtension: "wav") {
            backgroundMusic = SKAudioNode(url: musicURL)
            addChild(backgroundMusic)
        }

        
        scene?.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        
        
        let path = Bundle.main.path(forResource: "MyParticle", ofType: "sks")
        let rainParticle = NSKeyedUnarchiver.unarchiveObject(withFile: path!) as! SKEmitterNode
        
        rainParticle.position = CGPoint(x: 0, y: self.size.height + 100)
        rainParticle.zPosition = 0
        rainParticle.name = "rainParticle"
        rainParticle.targetNode = self.scene
        
        self.addChild(rainParticle)
        
        
        
        self.backgroundColor = UIColor(red:0.00, green:0.70, blue:0.00, alpha:1.0)
        
        physicsWorld.contactDelegate = self;
        //        physicsWorld.gravity = CGVector(dx: -200.0, dy: 0.0)
        
        spawnPlayer()
        spawnWall()
        spawnCoin()
        
        let spawn = SKAction.run(spawnEnemy1)
        let delay = SKAction.wait(forDuration: TimeInterval(0.7))
        let spawnThenDelay = SKAction.sequence([spawn, delay])
        let spawnThenDelayForever = SKAction.repeatForever(spawnThenDelay)
        self.run(spawnThenDelayForever)
        
//        let gloveAction = SKAction.run(spawnGlove)
//        let gloveDelay = SKAction.wait(forDuration: TimeInterval(2.0))
//        let spawnThenDelayGlove = SKAction.sequence([gloveAction, gloveDelay])
//        let spawnThenDelayForeverGlove = SKAction.repeatForever(spawnThenDelayGlove)
//        self.run(spawnThenDelayForeverGlove)
        
        let coinAction = SKAction.run(spawnCoin)
        let coinDelay = SKAction.wait(forDuration: TimeInterval(1.5))
        let spawnThenDelayCoin = SKAction.sequence([coinAction, coinDelay])
        let spawnThenDelayForeverCoin = SKAction.repeatForever(spawnThenDelayCoin)
        self.run(spawnThenDelayForeverCoin)
        
        if (videoTapped == false){
        numPoints = 0
        points.text = "\(numPoints)"
        }
        if videoTapped == true{
            points.text = "\(numPoints)"

        }

        points.fontName = "Futura-Bold"
        points.zPosition = 5
        points.position = CGPoint(x: 0, y: 200)
        points.fontColor = UIColor.white
        points.fontSize = 70
        addChild(points)
        
        numCoins = 0
        coinz.fontName = "Futura"
        coinz.zPosition = 5
        coinz.position = CGPoint(x: 0, y: 150)
        coinz.fontColor = UIColor.white
        coinz.fontSize = 30
        addChild(coinz)
        
        ledge.position = CGPoint(x: 0, y: (-self.size.height) - 50)
        ledge.size = CGSize(width: self.size.width, height: 50)
        ledge.zPosition = 1
        ledge.physicsBody = SKPhysicsBody(rectangleOf: ledge.size)
        ledge.physicsBody?.affectedByGravity = false
        ledge.physicsBody?.categoryBitMask = BodyType.ledge.rawValue
        ledge.physicsBody?.contactTestBitMask = BodyType.enemy.rawValue
        ledge.physicsBody?.isDynamic = false
        self.addChild(ledge)
        
        let rotateBall = SKAction.rotate(byAngle: -3.0, duration: 0.7)
        let rotateForever = SKAction.repeatForever(rotateBall)
        player.run(rotateForever)
        
    
        
    }
    

    
    func spawnPlayer(){
        
        if (noPlayersSelected == true){
        player = SKSpriteNode(imageNamed: "baseballplayer.png")
        }
        if (metstouched == true) {
        player = mets
        }
        if (giantstouched == true) {
            player = giants
        }
        if (marlinstouched == true) {
            player = marlins
        }
        if (blackedtouched == true) {
            player = blacked
        }
        if (goldtouched == true) {
            player = gold
        }
        if (americantouched == true) {
            player = american
            
            let emitter = SKEmitterNode(fileNamed: "americantrail.sks")
            emitter?.targetNode = scene
            player.addChild(emitter!)

        }
        if (player1touched == true) {
            player = player1
        }
        if (moneytouched == true) {
            player = money
        }
        if (fidgettouched == true) {
            player = fidget
        }
        player.position = CGPoint(x: (self.size.width / 2) - (115/2), y: -self.size.height / 4)
        player.size = CGSize(width: 40, height: 40)
        player.zPosition = 2
        addChild(player)
        
        player.physicsBody = SKPhysicsBody(circleOfRadius: player.size.width / 2)
        player.physicsBody?.allowsRotation = false
        player.physicsBody?.categoryBitMask = BodyType.player.rawValue
        player.physicsBody?.collisionBitMask = BodyType.enemy.rawValue
        player.physicsBody?.contactTestBitMask = BodyType.enemy.rawValue
        player.physicsBody?.affectedByGravity = false
        

        
//        let emitter = SKEmitterNode(fileNamed: "trail.sks")
//        emitter?.targetNode = scene
//        player.addChild(emitter!)
        
    }
    
    func spawnWall(){
        groundBottom = SKSpriteNode(imageNamed: "Dirt.png")
        groundBottom.position = CGPoint(x: -(self.size.width / 2), y: 0 )
        groundBottom.size = CGSize(width: 75, height: self.size.height)
        addChild(groundBottom)
        groundBottom.zPosition = 1
        
        groundBottom.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: groundBottom.size.width, height: groundBottom.size.height))
        groundBottom.physicsBody?.allowsRotation = false
        groundBottom.physicsBody?.categoryBitMask = BodyType.floor.rawValue
        groundBottom.physicsBody?.collisionBitMask = BodyType.player.rawValue
        groundBottom.physicsBody?.contactTestBitMask = BodyType.player.rawValue
        groundBottom.physicsBody?.affectedByGravity = false
        groundBottom.physicsBody?.isDynamic = false
        
        // set the enemy
        groundTop = SKSpriteNode(imageNamed: "Dirt.png")
        // position of the enemy
        groundTop.position = CGPoint(x: self.size.width / 2, y: 0)
        // 5
        groundTop.size = CGSize(width: 75, height: self.size.height)
        addChild(groundTop)
        groundTop.zPosition = 1
        
        groundTop.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: groundTop.size.width, height: groundTop.size.height))
        groundTop.physicsBody?.allowsRotation = false
        groundTop.physicsBody?.categoryBitMask = BodyType.floor.rawValue
        groundTop.physicsBody?.collisionBitMask = BodyType.player.rawValue
        groundTop.physicsBody?.contactTestBitMask = BodyType.player.rawValue
        groundTop.physicsBody?.affectedByGravity = false
        groundTop.physicsBody?.isDynamic = false
        
    }
    
    func spawnEnemy1(){
        
        let randomImageNumber = arc4random()%4
        //        print("\(randomImageNumber)")
        
        if (randomImageNumber == 0) {
            // set the enemy
            enemy1 = SKSpriteNode(imageNamed: "enemybaseballgreen.png")
            // position of the enemy
            enemy1.position = CGPoint(x: (self.size.width / 2) - 15, y: self.size.height)
            // 5
            enemy1.size = CGSize(width: 50, height: 250)
            addChild(enemy1)
            enemy1.zPosition = 2
            
            enemy1.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: enemy1.size.width, height: enemy1.size.height / 1.7))
            enemy1.physicsBody?.allowsRotation = false
            enemy1.physicsBody?.categoryBitMask = BodyType.enemy.rawValue
            enemy1.physicsBody?.collisionBitMask = BodyType.player.rawValue
            enemy1.physicsBody?.contactTestBitMask = BodyType.player.rawValue
            enemy1.physicsBody?.affectedByGravity = false
            
            let moveEnemy1 = SKAction.move(to: CGPoint(x: (self.size.width / 2) - 15 ,y: (-self.size.height) - 100), duration: duration)
            let delay = SKAction.wait(forDuration: 0.0)
            let sequence1 = SKAction.sequence([delay, moveEnemy1, delay])
            enemy1.run(sequence1)
            
        }
        if (randomImageNumber == 1){
            // set the enemy
            enemy2 = SKSpriteNode(imageNamed: "enemybaseballgreen.png")
            // position of the enemy
            enemy2.position = CGPoint(x: (-self.size.width / 2) + 15, y: self.size.height)
            // 5
            enemy2.size = CGSize(width: 50, height: 250)
            addChild(enemy2)
            enemy2.zPosition = 2
            
            enemy2.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: enemy2.size.width, height: enemy2.size.height / 1.5))
            enemy2.physicsBody?.allowsRotation = false
            enemy2.physicsBody?.categoryBitMask = BodyType.enemy.rawValue
            enemy2.physicsBody?.collisionBitMask = BodyType.player.rawValue
            enemy2.physicsBody?.contactTestBitMask = BodyType.player.rawValue
            enemy2.physicsBody?.affectedByGravity = false
            
            let moveEnemy2 = SKAction.move(to: CGPoint(x: -(self.size.width / 2) + 15 ,y: (-self.size.height) - 100), duration: duration)
            let delay2 = SKAction.wait(forDuration: 0.0)
            let sequence2 = SKAction.sequence([delay2, moveEnemy2, delay2])
            enemy2.run(sequence2)
        }
        
        if (randomImageNumber == 2){
            // set the enemy
            enemy3 = SKSpriteNode(imageNamed: "baseballenemyspikes.png")
            // position of the enemy
            enemy3.position = CGPoint(x: (self.size.width / 2) - 12, y: self.size.height)
            // 5
            enemy3.size = CGSize(width: 80, height: 200)
            addChild(enemy3)
            enemy3.zPosition = 2
            
            enemy3.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: enemy3.size.width, height: enemy3.size.height/1.5))
            enemy3.physicsBody?.allowsRotation = false
            enemy3.physicsBody?.categoryBitMask = BodyType.enemy.rawValue
            enemy3.physicsBody?.collisionBitMask = BodyType.player.rawValue
            enemy3.physicsBody?.contactTestBitMask = BodyType.player.rawValue
            enemy3.physicsBody?.affectedByGravity = false
            
            let moveEnemy3 = SKAction.move(to: CGPoint(x: (self.size.width / 2) - 12 ,y: (-self.size.height) - 100), duration: duration)
            let delay3 = SKAction.wait(forDuration: 0.0)
            let sequence3 = SKAction.sequence([delay3, moveEnemy3, delay3])
            enemy3.run(sequence3)
        }
        
        if (randomImageNumber == 3){
            // set the enemy
            enemy4 = SKSpriteNode(imageNamed: "baseballenemyspikes2.png")
            // position of the enemy
            enemy4.position = CGPoint(x: (-self.size.width / 2) + 12, y: self.size.height)
            // 5
            enemy4.size = CGSize(width: 80, height: 200)
            addChild(enemy4)
            enemy4.zPosition = 2
            
            enemy4.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: enemy4.size.width, height: enemy4.size.height/1.7))
            enemy4.physicsBody?.allowsRotation = false
            enemy4.physicsBody?.categoryBitMask = BodyType.enemy.rawValue
            enemy4.physicsBody?.collisionBitMask = BodyType.player.rawValue
            enemy4.physicsBody?.contactTestBitMask = BodyType.player.rawValue
            enemy4.physicsBody?.affectedByGravity = false
            
            let moveEnemy4 = SKAction.move(to: CGPoint(x: (-self.size.width / 2) + 12 ,y: (-self.size.height) - 100), duration: duration)
            let delay4 = SKAction.wait(forDuration: 0.0)
            let sequence4 = SKAction.sequence([delay4, moveEnemy4, delay4])
            enemy4.run(sequence4)
        }
    }
    
    
//    func spawnGlove(){
//        
//        let randomGlove = arc4random()%2
//        //        print("\(randomGlove)")
//        
//        if (randomGlove == 0) {
//            // set the enemy
//            glove1 = SKSpriteNode(imageNamed: "gloveattempt.png")
//            // position of the enemy
//            glove1.position = CGPoint(x: (self.size.width / 2) - 25, y: self.size.height)
//            // 5
//            glove1.size = CGSize(width: 45, height: 45)
//            addChild(glove1)
//            glove1.zPosition = 2
//            
//            glove1.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: glove1.size.width, height: glove1.size.height))
//            glove1.physicsBody?.allowsRotation = false
//            glove1.physicsBody?.categoryBitMask = BodyType.enemy.rawValue
//            glove1.physicsBody?.collisionBitMask = BodyType.player.rawValue
//            glove1.physicsBody?.contactTestBitMask = BodyType.player.rawValue
//            glove1.physicsBody?.affectedByGravity = false
//            
//            let moveGlove1 = SKAction.move(to: CGPoint(x: -(self.size.width / 2) + 25 ,y: (-self.size.height) - 100), duration: 1.7)
//            let delayGlove1 = SKAction.wait(forDuration: 0.0)
//            _ = SKAction.sequence([delayGlove1, moveGlove1, delayGlove1])
//            glove1.run(moveGlove1)
//            
//        }
//        
//        if (randomGlove == 1) {
//            // set the enemy
//            glove2 = SKSpriteNode(imageNamed: "gloveattempt.png")
//            // position of the enemy
//            glove2.position = CGPoint(x: -(self.size.width / 2) + 25, y: self.size.height)
//            // 5
//            glove2.size = CGSize(width: 45, height: 45)
//            addChild(glove2)
//            glove1.zPosition = 2
//            
//            glove2.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: glove2.size.width, height: glove2.size.height))
//            glove2.physicsBody?.allowsRotation = false
//            glove2.physicsBody?.categoryBitMask = BodyType.enemy.rawValue
//            glove2.physicsBody?.collisionBitMask = BodyType.player.rawValue
//            glove2.physicsBody?.contactTestBitMask = BodyType.player.rawValue
//            glove2.physicsBody?.affectedByGravity = false
//            
//            let moveGlove2 = SKAction.move(to: CGPoint(x: (self.size.width / 2) - 25 ,y: (-self.size.height) - 100), duration: 1.7)
//            let delayGlove2 = SKAction.wait(forDuration: 0.0)
//            _ = SKAction.sequence([delayGlove2, moveGlove2, delayGlove2])
//            glove2.run(moveGlove2)
//            
//        }
//        
//    }
    
    func spawnCoin(){
        
            let randomCoin = arc4random()%2
        
        if (randomCoin == 0) {

            coin = SKSpriteNode(imageNamed: "coinsbaseball.png")
            coin.size = CGSize(width: 20, height: 25)
            coin.position = CGPoint(x: (self.size.width / 2) - 50, y: self.size.height)
            addChild(coin)
            
            coin.zPosition = 4
            
            coin.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: coin.size.width, height: coin.size.height))
            coin.physicsBody?.allowsRotation = false
            coin.physicsBody?.categoryBitMask = BodyType.coin.rawValue
            coin.physicsBody?.collisionBitMask = BodyType.player.rawValue
            coin.physicsBody?.contactTestBitMask = BodyType.player.rawValue
            coin.physicsBody?.affectedByGravity = false
            
            let moveCoin1 = SKAction.move(to: CGPoint(x: (self.size.width / 2) - 50 ,y: (-self.size.height) - 100), duration: duration)
            let delayCoin1 = SKAction.wait(forDuration: 0.0)
            _ = SKAction.sequence([delayCoin1, moveCoin1, delayCoin1])
            coin.run(moveCoin1)

        }
        
        if (randomCoin == 1) {
            coin2 = SKSpriteNode(imageNamed: "coinsbaseball.png")
            coin2.size = CGSize(width: 20, height: 25)
            coin2.position = CGPoint(x: -(self.size.width / 2) + 50, y: self.size.height)
            addChild(coin2)

            coin2.zPosition = 4
            
            coin2.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: coin2.size.width, height: coin2.size.height))
            coin2.physicsBody?.allowsRotation = false
            coin2.physicsBody?.categoryBitMask = BodyType.coin.rawValue
            coin2.physicsBody?.collisionBitMask = BodyType.player.rawValue
            coin2.physicsBody?.contactTestBitMask = BodyType.player.rawValue
            coin2.physicsBody?.affectedByGravity = false
            
            let moveCoin2 = SKAction.move(to: CGPoint(x: -(self.size.width / 2) + 50 ,y: (-self.size.height) - 100), duration: duration)
            let delayCoin2 = SKAction.wait(forDuration: 0.0)
            _ = SKAction.sequence([delayCoin2, moveCoin2, delayCoin2])
            coin2.run(moveCoin2)
        }

    }

    
    func reverseGravity() {

        player.position.x *= -1
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if (fidgettouched == false) {
        numPoints += 1
        }
        
        if (fidgettouched == true) {
        numPoints += 2
        }
        points.text = "\(numPoints)"
        
        pos *= -1
        
        run(thud)
        
        if (pos == -1){
            
            let moveLeft = SKAction.move(to: CGPoint(x: -(self.size.width / 2) + (115/2), y: -self.size.height / 4), duration: 0.1)
            player.run(moveLeft)
            
            
        }
        
        if (pos == 1){
            
            let moveRight = SKAction.move(to: CGPoint(x: (self.size.width / 2) - (115/2), y: -self.size.height / 4), duration: 0.1)
            player.run(moveRight)
            
        }
        
        
        if (numPoints == 30){
        duration = 1.6
        }
        if (numPoints == 50){
        duration = 1.4
        }
        if (numPoints == 70){
        duration = 1.3
        }
        if (numPoints == 90){
        duration = 1.2
        }
        
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        
        let firstBody : SKPhysicsBody = contact.bodyA
        let secondBody : SKPhysicsBody = contact.bodyB
        
        if (((firstBody.categoryBitMask == BodyType.player.rawValue) && (secondBody.categoryBitMask == BodyType.enemy.rawValue)) || ((firstBody.categoryBitMask == BodyType.enemy.rawValue) && (secondBody.categoryBitMask == BodyType.player.rawValue))) {
            gameOver()
        }
            
        else if (((firstBody.categoryBitMask == BodyType.ledge.rawValue) && (secondBody.categoryBitMask == BodyType.enemy.rawValue)) || ((firstBody.categoryBitMask == BodyType.enemy.rawValue) && (secondBody.categoryBitMask == BodyType.ledge.rawValue))) {
            
            removeEnemy(firstBody.node as! SKSpriteNode, ledge: secondBody.node as! SKSpriteNode)
            
            
        }
        
        else if (((firstBody.categoryBitMask == BodyType.coin.rawValue) && (secondBody.categoryBitMask == BodyType.player.rawValue)) || ((firstBody.categoryBitMask == BodyType.player.rawValue) && (secondBody.categoryBitMask == BodyType.coin.rawValue))) {
            
            print("collected coin")
            
            removeCoin(firstBody.node as! SKSpriteNode, player: secondBody.node as! SKSpriteNode)
            
            
        }

        
    }
    
    func removeEnemy(_ enemy:SKSpriteNode, ledge: SKSpriteNode){
        ledge.removeFromParent()
    }
    
    func removeCoin(_ coin:SKSpriteNode, player: SKSpriteNode){
        
        coin.removeFromParent()
        run(ping)
        
        if (moneytouched == false){
        numCoins += 1
        }
        
        if (moneytouched == true){
        numCoins += 2
        }
        
        
        coinz.text = "\(numCoins)"
        

    }
    
    func gameOver() {
        
        player.removeFromParent()
        player.removeAllActions()
        
        gameOverBool = true
        let sceneToMoveTo = MainMenuScene(size: self.size)
        sceneToMoveTo.scaleMode = self.scaleMode
        let sceneTransition = SKTransition.fade(withDuration: 0.2)
        self.view?.presentScene(sceneToMoveTo, transition: sceneTransition)
        adNum = adNum + 1
        
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered

    }
    
}
