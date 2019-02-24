//
// ViewController.swift
// BadaniaAR2019
//
// Created by AT Wolfar on 10/02/2019.
// Copyright © 2019 PUMTeam. All rights reserved.
//

import UIKit
import ARKit

class ViewController: UIViewController {
    

    //====================================
    //====================================
    
   @IBOutlet weak var sceneView: ARSCNView!

   override func viewDidLoad() {
       super.viewDidLoad()
       addBox()
       addBox2()
       addTapGestureToSceneView()
   }

   override func viewWillAppear(_ animated: Bool) {
       super.viewWillAppear(animated)
       let configuration = ARWorldTrackingConfiguration()
       sceneView.session.run(configuration)
   }

   override func viewWillDisappear(_ animated: Bool) {
       super.viewWillDisappear(animated)
       sceneView.session.pause()
   }

    
   func addBox(x: Float = 0, y: Float = 0, z: Float = -0.2) {
       let box = SCNBox(width: 0.1, height: 0.1, length: 0.1, chamferRadius: 0)

       let boxNode = SCNNode()
       boxNode.geometry = box
       boxNode.position = SCNVector3(x, y, z)

       sceneView.scene.rootNode.addChildNode(boxNode)
   }

    
  func addBox() {
      let box = SCNBox(width: 0.1, height: 0.1, length: 0.1, chamferRadius: 0)

      let boxNode = SCNNode()
      boxNode.geometry = box
      boxNode.position = SCNVector3(0, 0, -0.2)

      let scene = SCNScene()
      scene.rootNode.addChildNode(boxNode)
      sceneView.scene = scene
  }

   func addBox2() {
       let box = SCNBox(width: 0.05, height: 0.05, length: 0.05, chamferRadius: 0)

       let boxNode = SCNNode()
       boxNode.geometry = box
       boxNode.position = SCNVector3(0, 10, -0.5)

       sceneView.scene.rootNode.addChildNode(boxNode)
   }

   func addTapGestureToSceneView() {
       let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ViewController.didTap(withGestureRecognizer:)))
       sceneView.addGestureRecognizer(tapGestureRecognizer)
   }

   @objc func didTap(withGestureRecognizer recognizer: UIGestureRecognizer) {
       let tapLocation = recognizer.location(in: sceneView)
       let hitTestResults = sceneView.hitTest(tapLocation)
       guard let node = hitTestResults.first?.node else {
           let hitTestResultsWithFeaturePoints = sceneView.hitTest(tapLocation, types: .featurePoint)
           if let hitTestResultWithFeaturePoints = hitTestResultsWithFeaturePoints.first {
               let translation = hitTestResultWithFeaturePoints.worldTransform.translation
               addBox(x: translation.x, y: translation.y, z: translation.z)
           }
           return
       }
       node.removeFromParentNode()
    }

}

extension float4x4 {
   var translation: float3 {
       let translation = self.columns.3
       return float3(translation.x, translation.y, translation.z)
   }
}


