//
//  ZSHelloscene.swift
//  spriteKitDemo
//
//  Created by 紫贝壳 on 2016/12/27.
//  Copyright © 2016年 紫贝壳. All rights reserved.
//

import UIKit
import SpriteKit
class ZSHelloscene: SKScene {
    
    private var contentCreate:Bool = false

    override func didMove(to view: SKView) {
        if contentCreate == false {
            createContent()
            contentCreate = true;
        }
    }
    
    func createContent() {
        backgroundColor = UIColor.blue
        scaleMode = .aspectFit
        addChild(newHelloNode())
    }
    
    func newHelloNode()->(SKNode) {
       let hellonode:SKLabelNode = SKLabelNode.init()
        hellonode.text = "hello world"
        hellonode.name = "hellonode"
        hellonode.fontSize = 42
        hellonode.position = CGPoint(x: self.frame.midX, y: self.frame.midX)
        return hellonode
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let hellonode:SKNode = childNode(withName: "hellonode")!
        hellonode.name = nil
       let moveup:SKAction = SKAction.moveBy(x: 0, y: 100, duration: 0.5)
        let zoom:SKAction = SKAction.scale(to: 2.0, duration: 0.25)
        let pause:SKAction = SKAction.wait(forDuration: 0.5)
        let fadeAway:SKAction = SKAction.fadeOut(withDuration: 0.25)
        let remove:SKAction = SKAction.removeFromParent()
        let mover:SKAction = SKAction.sequence([moveup,zoom,pause,fadeAway,remove])
        hellonode .run(mover) { 
            let spaceScene:SKScene = spaceshipScene()
            spaceScene.size = self.size
            let doors:SKTransition = SKTransition.doorsOpenVertical(withDuration: 0.5)
            self.view?.presentScene(spaceScene, transition: doors)
            
        }
        
        
        
    }
    
    
    
    
    
    
    
    
    
    
    
}
