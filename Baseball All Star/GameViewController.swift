//
//  GameViewController.swift
//  Gravity Swap
//
//  Created by Vlad verba  on 6/11/17.
//  Copyright © 2017 vladverba. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit
import GoogleMobileAds

class GameViewController: UIViewController, GADBannerViewDelegate {
    
    var interGO: GADInterstitial!
    
    @IBOutlet var banner: GADBannerView!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()

        
        let scene = MainMenuScene(size: CGSize(width: 640, height: 1136))
        let skView = self.view as! SKView
        skView.showsFPS = false
        skView.showsNodeCount = false
        skView.ignoresSiblingOrder = true
        skView.showsPhysics = false
        scene.scaleMode = .resizeFill
        skView.presentScene(scene)
        
        let request = GADRequest()
        request.testDevices = [kGADSimulatorID]
        banner.delegate = self
        banner.adUnitID = "ca-app-pub-7575941856999317/7452195188"
        banner.rootViewController = self
        banner.load(request)
        
//        banner.isHidden = true
        
        NotificationCenter.default.addObserver(self, selector: #selector(showGameOverAd), name: NSNotification.Name(rawValue: "ShowInterAd"), object: nil)
        
        interGO = GADInterstitial(adUnitID: "ca-app-pub-7575941856999317/2352514386")
        
        let requestGO = GADRequest()
        interGO.load(requestGO)


        
        
    }
    
    func showGameOverAd() {
        
        if(interGO.isReady){
            self.interGO.present(fromRootViewController: self)
            interGO = createAd()
            print("present ad")
        }
        
        
    }
    
    func createAd() -> GADInterstitial {
        
        let interGO = GADInterstitial(adUnitID: "ca-app-pub-7575941856999317/2352514386")
        interGO.load(GADRequest())
        return interGO
        
    }

    
    override var shouldAutorotate: Bool {
        return true
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }
    
//    func adViewDidReceiveAd(_ bannerView: GADBannerView) {
//        banner.isHidden = false
//    }
//    func adView(_ bannerView: GADBannerView, didFailToReceiveAdWithError error: GADRequestError) {
//        banner.isHidden = true
//        print("does not show")
//    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
}
