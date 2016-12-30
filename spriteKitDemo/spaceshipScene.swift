//
//  spaceshipScene.swift
//  spriteKitDemo
//
//  Created by 紫贝壳 on 2016/12/27.
//  Copyright © 2016年 紫贝壳. All rights reserved.
//

import UIKit
import SpriteKit

//static const uint32_t projectileCategory     =  0x1 << 0;
//static const uint32_t monsterCategory        =  0x1 << 1;
class spaceshipScene: SKScene,SKPhysicsContactDelegate {
    var contentCreate:Bool = false
    var hull:SKSpriteNode? = nil
     let projectileCategory:UInt32  = 0x00000001
     let monsterCategory:UInt32 = 0x00000010
    let hullategory:UInt32 = 0x00000011

    override func didMove(to view: SKView) {
        if contentCreate == false {
            createContent()
            self.physicsWorld.contactDelegate = self;
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
        
        //创建子弹
        let makebullet:SKAction = SKAction.sequence([SKAction.perform(#selector(spaceshipScene.addbullet), onTarget: self),SKAction.wait(forDuration: 0.1, withRange: 0.15)])
        self.run(SKAction.repeatForever(makebullet))
        
    }
    
    func addbullet() {
        let bullet:SKSpriteNode = SKSpriteNode.init(color: UIColor.red, size: CGSize(width: 4, height: 4))
        let fireaction:SKAction = SKAction.moveBy(x: 0, y: UIScreen.main.bounds.size.height, duration: 1.0)
        bullet.run(SKAction.repeatForever(fireaction))
        bullet.position = (self.hull?.position)!
        bullet.name = "bullet"
        bullet.physicsBody = SKPhysicsBody.init(rectangleOf: bullet.size)
        bullet.physicsBody?.usesPreciseCollisionDetection = true
        bullet.physicsBody?.isDynamic = false;
        bullet.physicsBody?.categoryBitMask = monsterCategory
        bullet.physicsBody?.contactTestBitMask = projectileCategory
        bullet.physicsBody?.collisionBitMask = 0
        self.addChild(bullet)
        
    }
    
    func addrocks() {
        let rocks:SKSpriteNode = SKSpriteNode.init(color: UIColor.brown, size: CGSize(width: 20, height: 20))
        rocks.position = CGPoint(x: randWithW(), y: self.size.height - 50)
        rocks.name = "rock"
        rocks.physicsBody = SKPhysicsBody.init(rectangleOf: rocks.size)
        rocks.physicsBody?.usesPreciseCollisionDetection = true
        rocks.physicsBody?.categoryBitMask = projectileCategory
        rocks.physicsBody?.contactTestBitMask = monsterCategory
        rocks.physicsBody?.collisionBitMask = 0
        self.addChild(rocks)
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        var firstBody:SKPhysicsBody?
        var secoundBody:SKPhysicsBody?
        if (contact.bodyA.node?.name == "hull") || (contact.bodyB.node?.name == "hull") {
            return
        }
        if contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask {
            firstBody = contact.bodyA
            secoundBody = contact.bodyB
        }else{
            firstBody = contact.bodyB
            secoundBody = contact.bodyA
        }
        if ((firstBody?.categoryBitMask)! & projectileCategory) != 0 && ((secoundBody?.categoryBitMask)! & monsterCategory) != 0 {
            if (firstBody?.node as? SKSpriteNode != nil) && (secoundBody?.node as? SKSpriteNode != nil) {
                projectRemoveRocks(bullet: firstBody?.node as! SKSpriteNode, rock: secoundBody?.node as! SKSpriteNode)
            }
        }
    }
    
    func projectRemoveRocks(bullet:SKSpriteNode, rock:SKSpriteNode) {
//        print(bullet,rock)
        bullet.removeFromParent()
        rock.removeFromParent()
    }
    
    func randWithW() -> CGFloat {
        return CGFloat(arc4random()) / CGFloat(RAND_MAX) * self.size.width
    }
    
    func newSpaceship()->(SKSpriteNode) {
        let hull:SKSpriteNode = SKSpriteNode.init(color: UIColor.gray, size: CGSize(width: 64, height: 32))
        hull.name = "hull"
        hull.physicsBody?.categoryBitMask = hullategory
        self.hull = hull
        
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
        self.enumerateChildNodes(withName: "bullet") { (node, stop) in
            if node.position.y > UIScreen.main.bounds.size.height {
                node.removeFromParent()
            }
        }

    }
    
    
    
    
    
}
