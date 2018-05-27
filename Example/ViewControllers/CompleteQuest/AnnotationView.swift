//
//  AnnotationView.swift
//  Example
//
//  Created by Pabel Nunez Landestoy on 5/26/18.
//  Copyright © 2018 Pocket Network. All rights reserved.
//

import UIKit
import SceneKit

protocol AnnotationViewDelegate {
    func didTouch(annotationView: AnnotationView)
}

class AnnotationView: ARAnnotationView {

    var titleLabel: UILabel?
    var distanceLabel: UILabel?
    var sceneView: SCNView?
    var submitButton: UIButton?
    var delegate: AnnotationViewDelegate?
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        
        loadUI()
    }
    
    func loadUI() {
        titleLabel?.removeFromSuperview()
        distanceLabel?.removeFromSuperview()
        sceneView?.removeFromSuperview()
        submitButton?.removeFromSuperview()
        
        // Title label
        let label = UILabel(frame: CGRect(x: 10, y: 0, width: self.frame.size.width, height: 30))
        
        label.font = UIFont.systemFont(ofSize: 16)
        label.numberOfLines = 0
        label.backgroundColor = UIColor(white: 0.3, alpha: 0.7)
        label.textColor = UIColor.yellow
        
        self.addSubview(label)
        self.titleLabel = label
        
        // Distance label
        let label2 = UILabel(frame: CGRect(x: 10, y: 30, width: self.frame.size.width, height: 20))
        
        label2.backgroundColor = UIColor(white: 0.3, alpha: 0.7)
        label2.textColor = UIColor.green
        label2.font = UIFont.systemFont(ofSize: 12)
        
        self.addSubview(label2)
        self.distanceLabel = label2
        
        // Annotation setup
        if let annotation = annotation {
            // Quest Info
            titleLabel?.text = annotation.title
            distanceLabel?.text = String(format: "%.2f km", annotation.distanceFromUser / 1000)
            
            // Scene for 3d object
            let myView = SCNView(frame: CGRect(x: 10, y: 30, width: 180, height: 180), options: nil)
            
            myView.scene = SCNScene.init(named: "banana.dae")
            myView.allowsCameraControl = true
            myView.autoenablesDefaultLighting = true
            myView.backgroundColor = UIColor.clear
            
            self.addSubview(myView)
            sceneView = myView
            
            // Submit button
            let button = UIButton(frame: CGRect(x: 10, y: self.frame.height, width: self.frame.width - 10, height: 35))
            
            button.setTitle("Submit", for: .normal)
            button.layer.cornerRadius = 10
            button.addTarget(self, action: #selector(self.pressButton(_:)), for: .touchUpInside)
            button.backgroundColor = UIColor.blue
            
            self.addSubview(button)
            submitButton = button
        }
    }
    
    @objc func pressButton(_ sender: UIButton){
        print("\(sender)")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        titleLabel?.frame = CGRect(x: 10, y: 0, width: self.frame.size.width, height: 30)
        distanceLabel?.frame = CGRect(x: 10, y: 30, width: self.frame.size.width, height: 20)
        sceneView?.frame = CGRect(x: 10, y: 30, width: 180, height: 180)
        submitButton?.frame = CGRect(x: 10, y: self.frame.height, width: self.frame.width - 10, height: 35)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        delegate?.didTouch(annotationView: self)
    }
}
