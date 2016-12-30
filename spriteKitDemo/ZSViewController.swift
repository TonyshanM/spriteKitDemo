//
//  ZSViewController.swift
//  spriteKitDemo
//
//  Created by 紫贝壳 on 2016/12/27.
//  Copyright © 2016年 紫贝壳. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit
class ZSViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let zsview:SKView = self.view as! SKView
        zsview.showsFPS = true
        zsview.showsDrawCount = true
        zsview.showsNodeCount = true
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    override func viewWillAppear(_ animated: Bool) {
       let hello:ZSHelloscene = ZSHelloscene()
        hello.size = CGSize(width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)
       let spritekit:SKView = self.view as! SKView
        spritekit.presentScene(hello)
        
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
