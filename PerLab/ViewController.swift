//
//  ViewController.swift
//  PerLab
//
//  Created by Lanqing Liu on 10/5/19.
//  Copyright © 2019 Lanqing Liu. All rights reserved.
//

import UIKit
import ARKit

class ViewController: UIViewController {

    /// Primary SceneKit view that renders the AR session
    @IBOutlet var sceneView: ARSCNView!
    
    /// A serial queue for thread safety when modifying SceneKit's scene graph.
    let updateQueue = DispatchQueue(label: "\(Bundle.main.bundleIdentifier!).serialSCNQueue")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's delegate
        sceneView.delegate = self
        
        // Show statistics such as fps and timing information
        sceneView.showsStatistics = true
        
        // Enable environment-based lighting
        sceneView.autoenablesDefaultLighting = true
        sceneView.automaticallyUpdatesLighting = true
        
        // Create a new scene, where the plane will be.
        // let scene = SCNScene(named: "art.scnassets/ship.scn")!
        let scene = SCNScene()
        
        // Set the scene to the view
        sceneView.scene = scene
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        guard let refImages = ARReferenceImage.referenceImages(inGroupNamed: "Cards", bundle: Bundle.main) else {
                       fatalError("Missing expected asset catalog resources.")
               }
        
        // Create a session configuration
        let configuration = ARImageTrackingConfiguration()
            configuration.trackingImages = refImages
            configuration.maximumNumberOfTrackedImages = 10
                  
        
        // Run the view's session  pdpTracking
        sceneView.session.run(configuration,options: ARSession.RunOptions(arrayLiteral: [.resetTracking, .removeExistingAnchors]))
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }

}
