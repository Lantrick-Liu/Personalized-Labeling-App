//
//  ViewController+ARSCNViewDelegate.swift
//  PerLab
//
//  Created by Lanqing Liu on 10/6/19.
//  Copyright © 2019 Lanqing Liu. All rights reserved.
//

import UIKit
import SceneKit
import ARKit


extension ViewController: ARSCNViewDelegate {

 
    /*
    // MARK: - ARSCNViewDelegate
    
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        guard let imageAnchor = anchor as? ARImageAnchor else { return }
        
        updateQueue.async {
            let physicalWidth = imageAnchor.referenceImage.physicalSize.width
            let physicalHeight = imageAnchor.referenceImage.physicalSize.height
            
            // Create a plane geometry to visualize the initial position of the detected image
            let mainPlane = SCNPlane(width: physicalWidth, height: physicalHeight)
            mainPlane.firstMaterial?.colorBufferWriteMask = .alpha
            
            // Create a SceneKit root node with the plane geometry to attach to the scene graph
            // This node will hold the virtual UI in place
            let mainNode = SCNNode(geometry: mainPlane)
            mainNode.eulerAngles.x = -.pi / 2
            mainNode.renderingOrder = -1
            mainNode.opacity = 1
            
            // Add the plane visualization to the scene
            node.addChildNode(mainNode)
            
            // Perform a quick animation to visualize the plane on which the image was detected.
            // We want to let our users know that the app is responding to the tracked image.
            self.highlightDetection(on: mainNode, width: physicalWidth, height: physicalHeight, completionHandler: {
                
                // Introduce virtual content
                self.displayDetailView(on: mainNode, xOffset: physicalWidth)
                
                // Animate the WebView to the right
                self.displayWebView(on: mainNode, xOffset: physicalWidth)
                
            })
        }
    }
    
    func session(_ session: ARSession, didFailWithError error: Error) {
        // Present an error message to the user
        
    }
    
    func sessionWasInterrupted(_ session: ARSession) {
        // Inform the user that the session has been interrupted, for example, by presenting an overlay
        
    }
    
    func sessionInterruptionEnded(_ session: ARSession) {
        // Reset tracking and/or remove existing anchors if consistent tracking is required
        
    }
    
    // MARK: - SceneKit Helpers
    
    func displayDetailView(on rootNode: SCNNode, xOffset: CGFloat) {
        let detailPlane = SCNPlane(width: xOffset, height: xOffset * 1.4)
        detailPlane.cornerRadius = 0.25
        
        let detailNode = SCNNode(geometry: detailPlane)
        detailNode.geometry?.firstMaterial?.diffuse.contents = SKScene(fileNamed: "DetailScene")
        
        // Due to the origin of the iOS coordinate system, SCNMaterial's content appears upside down, so flip the y-axis.
        detailNode.geometry?.firstMaterial?.diffuse.contentsTransform = SCNMatrix4Translate(SCNMatrix4MakeScale(1, -1, 1), 0, 1, 0)
        detailNode.position.z -= 0.5
        detailNode.opacity = 0
        
        rootNode.addChildNode(detailNode)
        detailNode.runAction(.sequence([
            .wait(duration: 1.0),
            .fadeOpacity(to: 1.0, duration: 1.5),
            .moveBy(x: xOffset * -1.1, y: 0, z: -0.05, duration: 1.5),
            .moveBy(x: 0, y: 0, z: -0.05, duration: 0.2)
            ])
        )
    }
    
    func displayWebView(on rootNode: SCNNode, xOffset: CGFloat) {
        // Xcode yells at us about the deprecation of UIWebView in iOS 12.0, but there is currently
        // a bug that does now allow us to use a WKWebView as a texture for our webViewNode
        // Note that UIWebViews should only be instantiated on the main thread!
        DispatchQueue.main.async {
            let request = URLRequest(url: URL(string: "https://www.worldwildlife.org/species/african-elephant#overview")!)
            let webView = UIWebView(frame: CGRect(x: 0, y: 0, width: 400, height: 672))
            webView.loadRequest(request)
                        
            let webViewPlane = SCNPlane(width: xOffset, height: xOffset * 1.4)
            webViewPlane.cornerRadius = 0.25
            
            let webViewNode = SCNNode(geometry: webViewPlane)
            webViewNode.geometry?.firstMaterial?.diffuse.contents = webView
            webViewNode.position.z -= 0.5
            webViewNode.opacity = 0
            
            rootNode.addChildNode(webViewNode)
            webViewNode.runAction(.sequence([
                .wait(duration: 3.0),
                .fadeOpacity(to: 1.0, duration: 1.5),
                .moveBy(x: xOffset * 1.1, y: 0, z: -0.05, duration: 1.5),
                .moveBy(x: 0, y: 0, z: -0.05, duration: 0.2)
                ])
            )
        }
    }
    
    func highlightDetection(on rootNode: SCNNode, width: CGFloat, height: CGFloat, completionHandler block: @escaping (() -> Void)) {
        let planeNode = SCNNode(geometry: SCNPlane(width: width, height: height))
        planeNode.geometry?.firstMaterial?.diffuse.contents = UIColor.white
        planeNode.position.z += 0.1
        planeNode.opacity = 0
        
        rootNode.addChildNode(planeNode)
        planeNode.runAction(self.imageHighlightAction) {
            block()
        }
    }
    
    var imageHighlightAction: SCNAction {
        return .sequence([
            .wait(duration: 0.25),
            .fadeOpacity(to: 0.85, duration: 0.25),
            .fadeOpacity(to: 0.15, duration: 0.25),
            .fadeOpacity(to: 0.85, duration: 0.25),
            .fadeOut(duration: 0.5),
            .removeFromParentNode()
            ])
    }
    
}
*/

   // MARK: - ARSCNViewDelegate
    var imageHighlightAction: SCNAction {
         return .sequence([
             //.wait(duration: 0.25),
             .fadeOpacity(to: 1, duration: 0.15),
             .fadeOpacity(to: 0.0, duration: 0.15),
             //.fadeOut(duration: 0.5),
             //.removeFromParentNode()
             ])
     }

    
    func adjustLabelFontSizeToFitRect(labelNode:SKLabelNode, rect:CGRect) {
        // Determine the font scaling factor that should let the label text fit in the given rectangle.
        let scalingFactor = min(rect.width / labelNode.frame.width, rect.height / labelNode.frame.height)
        // Change the fontSize.
        labelNode.fontSize *= scalingFactor - 1
        // Optionally move the SKLabelNode to the center of the rectangle.
        labelNode.position = CGPoint(x: rect.midX, y: 1.5 * rect.midY - labelNode.frame.height/2)
    }
    

    // Override to create and configure nodes for anchors added to the view's session.
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        let node = SCNNode()
            
         if let imageAnchor = anchor as? ARImageAnchor {
            
         
            
           //let _arry = [["Ok.png","This Drug is Safe!"],["Warn.png", "Attention to Drug Information!"],["No.jpg", "This Drug is not Safe for you!"]]
        
        let refimgName = imageAnchor.referenceImage.name
            var imageChecker = String()
            var stringChecker = String()
            
            if refimgName == "Tylenol" {
                imageChecker = "Warn.png"
                stringChecker = "Drug Interaction Risk!"
            } else if refimgName == "NcQuil" {
                imageChecker = "Ok.png"
                stringChecker = "Safe to Use for You."
            } else if refimgName == "Advil" {
                imageChecker = "No.jpg"
                stringChecker = "High Risk for You!"
            } else if refimgName == "TopCare" {
                imageChecker = "Warn.png"
                stringChecker = "Drug Interaction Risk!"
            }
           
        // TextNode Task

            let textNode = SKLabelNode (text: stringChecker)
            textNode.fontName = "Arial" // font how to change
            textNode.fontColor = UIColor.white
            textNode.yScale = -1.0
            
    
            let textScene = SKScene(size: CGSize(width: 1200, height: 400))
            
            let rect = CGRect(x: 0, y: 0, width: textScene.size.width, height: textScene.size.height)
            adjustLabelFontSizeToFitRect (labelNode: textNode, rect: rect)
            
            // textNode.position = CGPoint(x: textScene.size.width / 2, y: textScene.size.height / 2)
            textNode.alpha = 0.6
            textNode.color = UIColor(red:0.60, green:0.60, blue:0.60, alpha:1.0)
            textScene.addChild(textNode)
            
            let imageHeight = imageAnchor.referenceImage.physicalSize.height
            let imageWidth = imageAnchor.referenceImage.physicalSize.width
            let imagedimMin = min (imageHeight, imageWidth)
            
            let textPlane = SCNPlane(width: 2 * imagedimMin / 3 , height: imagedimMin / 5)
           
            textScene.scaleMode = .aspectFit
            //plane.firstMaterial?.transparencyMode = .aOne
            //plane.firstMaterial?.transparency = 0.5
            textPlane.firstMaterial?.diffuse.contents = textScene
            textPlane.cornerRadius = textPlane.height / 10
            
            let textPlaneNode = SCNNode(geometry: textPlane)
            
            textPlaneNode.position.x = Float(-0.5 * imageWidth + 0.46 * textPlane.width)
            textPlaneNode.position.z = Float(-0.5*imageHeight - 0.45 * textPlane.height)
            textPlaneNode.eulerAngles.x = -.pi / 2

            
            
        // ImageNode Task
            let imageNode = SKSpriteNode (imageNamed: imageChecker)
            let imageScene = SKScene(size: CGSize(width: 512, height: 512))

            imageNode.position = CGPoint(x: imageScene.size.width / 2, y: imageScene.size.height / 2)
            //textScene.alpha = 0.2
            imageNode.yScale = -1.0
     
            imageScene.addChild(imageNode)
            
            
            //let plane = SCNPlane(width: imageAnchor.referenceImage.physicalSize.width, height: imageAnchor.referenceImage.physicalSize.height)
            
            
            // let imagedimMax = max (imageAnchor.referenceImage.physicalSize.height, imageAnchor.referenceImage.physicalSize.width)
            let imagePlane = SCNPlane(width: imagedimMin / 3 , height: imagedimMin / 3)

            //plane.firstMaterial?.transparencyMode = .aOne
            //plane.firstMaterial?.transparency = 0.5
            imagePlane.firstMaterial?.diffuse.contents = imageScene
            imagePlane.cornerRadius = imagePlane.height / 2
            

            let imagePlaneNode = SCNNode(geometry: imagePlane)
            
            imagePlaneNode.position.x = Float(0.5*imageWidth)
            imagePlaneNode.position.z = Float(-0.5*imageHeight)
            imagePlaneNode.eulerAngles.x = -.pi / 2
            imagePlaneNode.flickFade(0.5)
           
            
            node.addChildNode(imagePlaneNode)
            node.addChildNode(textPlaneNode)


        }
        
        return node
    
    }
    
    func session(_ session: ARSession, didFailWithError error: Error) {
        // Present an error message to the user
        
    }
    
    func sessionWasInterrupted(_ session: ARSession) {
        // Inform the user that the session has been interrupted, for example, by presenting an overlay
        
    }
    
    func sessionInterruptionEnded(_ session: ARSession) {
        // Reset tracking and/or remove existing anchors if consistent tracking is required
        
    }
    


}

