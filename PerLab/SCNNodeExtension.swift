//
//  ViewController.swift
//  PerLab
//
//  Created by Lanqing Liu on 05/05/2022.
//  Copyright © 2022 Lanqing Liu. All rights reserved.

//

import Foundation
import UIKit
import ARKit

//-----------------------
//MARK: SCNNode Extension
//-----------------------

extension SCNNode{

    /// Creates A Pulsing Animation On An Infinite Loop
    ///
    /// - Parameter duration: TimeInterval
    func highlightNodeWithDurarion(_ duration: TimeInterval){

        
        //1. Create An SCNAction Which Emmits A Red Colour Over The Passed Duration Parameter
        let highlightAction = SCNAction.customAction(duration: duration) { (node, elapsedTime) in
            let typeH =  elapsedTime/CGFloat(duration)
            let color = UIColor(red: typeH, green: typeH, blue: typeH, alpha: 1)
            let currentMaterial = self.geometry?.firstMaterial
            currentMaterial?.emission.contents = color

        }

        //2. Create An SCNAction Which Removes The Red Emissio Colour Over The Passed Duration Parameter
        let unHighlightAction = SCNAction.customAction(duration: duration) { (node, elapsedTime) in
            let typeU =  elapsedTime/CGFloat(duration)
            let color = UIColor(red: CGFloat(1) - typeU, green: CGFloat(1) - typeU, blue: CGFloat(1) - typeU, alpha: 1)
            let currentMaterial = self.geometry?.firstMaterial
            currentMaterial?.emission.contents = color

        }

        //3. Create An SCNAction Sequence Which Runs The Actions
        let pulseSequence = SCNAction.sequence([highlightAction, unHighlightAction])

        //4. Set The Loop As Infinitie
        let infiniteLoop = SCNAction.repeatForever(pulseSequence)

        //5. Run The Action
        self.runAction(infiniteLoop)
    }


        func flickingBlock(_ duration: TimeInterval){

             // Create An SCNAction Which Emmits A Red Colour Over The Passed Duration Parameter
             let highlightAction = SCNAction.customAction(duration: duration) { (node, elapsedTime) in
                let typeH  =  floor (elapsedTime).truncatingRemainder(dividingBy:  2)
                self.opacity = typeH
            }

            // Create An SCNAction Sequence Which Runs The Actions
            let pulseSequence = SCNAction.sequence([highlightAction])

            //4. Set The Loop As Infinitie
            let infiniteLoop = SCNAction.repeatForever(pulseSequence)

            //5. Run The Action
            self.runAction(infiniteLoop)
        }
    
    
    func flickFade(_ duration: TimeInterval){

        
        //1. Create An SCNAction Which Emmits A Red Colour Over The Passed Duration Parameter
        let highlightAction = SCNAction.customAction(duration: duration) { (node, elapsedTime) in
            let typeH =  elapsedTime/CGFloat(duration)
            self.opacity = 5 * typeH
        }

        //2. Create An SCNAction Which Removes The Red Emissio Colour Over The Passed Duration Parameter
        let unHighlightAction = SCNAction.customAction(duration: duration) { (node, elapsedTime) in
            let typeU =  elapsedTime/CGFloat(duration)
            self.opacity = 1 - 5 * typeU
        }

        //3. Create An SCNAction Sequence Which Runs The Actions
        let pulseSequence = SCNAction.sequence([highlightAction, unHighlightAction])

        //4. Set The Loop As Infinitie
        let infiniteLoop = SCNAction.repeatForever(pulseSequence)

        //5. Run The Action
        self.runAction(infiniteLoop)
    }


    }
/*


*/

