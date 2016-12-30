//
//  spaceshipScene.swift
//  spriteKitDemo
//
//  Created by 紫贝壳 on 2016/12/27.
//  Copyright © 2016年 紫贝壳. All rights reserved.
//

import UIKit
import SpriteKit
class spaceshipScene: SKScene {
    var contentCreate:Bool = false
    var hull:SKSpriteNode? = nil
    
    override func didMove(to view: SKView) {
        if contentCreate == false {
            createContent()
            contentCreate = true
        }
    }
    
    func createContent()  {
        backgroundColor = UIColor.black
        scaleMode = .aspectFit
        let spaceship:SKSpriteNode = newSpaceship()
        spaceship.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
        self.addChild(spaceship)
        
        let makerocks:SKAction = SKAction.sequence([SKAction.perform(#selector(spaceshipScene.addrocks), onTarget: self),SKAction.wait(forDuration: 0.1, withRange: 0.15)])
        self.run(SKAction.repeatForever(makerocks))
        
    }
    
    func addrocks() {
        let rocks:SKSpriteNode = SKSpriteNode.init(color: UIColor.brown, size: CGSize(width: 8, height: 8))
        rocks.position = CGPoint(x: randWithW(), y: self.size.height - 50)
        rocks.name = "rock"
        rocks.physicsBody = SKPhysicsBody.init(rectangleOf: rocks.size)
        rocks.physicsBody?.usesPreciseCollisionDetection = true
        self.addChild(rocks)
    }
    
    func randWithW() -> CGFloat {
        return CGFloat(arc4random()) / CGFloat(RAND_MAX) * self.size.width
    }
    
    func newSpaceship()->(SKSpriteNode) {
        let hull:SKSpriteNode = SKSpriteNode.init(color: UIColor.gray, size: CGSize(width: 64, height: 32))
        self.hull = hull
//        let movers:SKAction = SKAction.sequence([SKAction.wait(forDuration: 1.0),SKAction.moveBy(x: 100, y: 50, duration: 1.0),SKAction.wait(forDuration: 1.0),SKAction.moveBy(x: -100, y: -50, duration: 1.0)])
//        hull.run(SKAction.repeatForever(movers))
        
        let lightL:SKSpriteNode = createLight()
        lightL.position = CGPoint(x: -28.0, y: 6)
        hull.addChild(lightL)
        let lightR:SKSpriteNode = createLight()
        lightR.position = CGPoint(x: 28.0, y: 6)
        hull.addChild(lightR)

        hull.physicsBody = SKPhysicsBody.init(rectangleOf: hull.size)
        hull.physicsBody?.isDynamic = false;
        return hull
    }
    
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches {
            self.hull?.position = t.location(in: self)
        }
    }

    
    func createLight() -> SKSpriteNode {
        let light:SKSpriteNode = SKSpriteNode.init(color: UIColor.yellow, size: CGSize(width: 8, height: 8))
        let lightmove:SKAction = SKAction.sequence([SKAction.fadeOut(withDuration: 0.25),SKAction.fadeIn(withDuration: 0.25)])
        light.run(SKAction.repeatForever(lightmove))
        return light
        
    }
    
    override func didSimulatePhysics() {
        self.enumerateChildNodes(withName: "rock") { (node, stop) in
            if node.position.y < 0 {
                node.removeFromParent()
            }
        }
    }
    
    
    
    
    
}
