//
//  AnnotationView.swift
//  Places
//
//  Created by Asif Newaz on 14/1/20.
//  Copyright © 2020 Razeware LLC. All rights reserved.
//

import UIKit

//1
protocol AnnotationViewDelegate {
  func didTouch(annotationView: AnnotationView)
}

//2
class AnnotationView: ARAnnotationView {
  //3
  var logoView: UIImageView?
  var titleLabel: UILabel?
  var distanceLabel: UILabel?
  var delegate: AnnotationViewDelegate?
  
  override func didMoveToSuperview() {
    super.didMoveToSuperview()
    
    loadUI()
  }
  
  //4
  func loadUI() {
    logoView?.removeFromSuperview()
    titleLabel?.removeFromSuperview()
    distanceLabel?.removeFromSuperview()
    
    let logo = UIImageView(frame: CGRect(x: 10, y: 10, width: 35, height: 35))
    logo.image = UIImage(named: "CB_Icon")
    self.addSubview(logo)
    self.logoView = logo
    
    let label = UILabel(frame: CGRect(x: 45, y: 6, width: self.frame.size.width, height: 25))
    label.font = UIFont.boldSystemFont(ofSize: 15)
    label.numberOfLines = 0
    //label.backgroundColor = UIColor(white: 0.3, alpha: 0.7)
    label.textColor = UIColor.white
    self.addSubview(label)
    self.titleLabel = label
    
    distanceLabel = UILabel(frame: CGRect(x: 45, y: 25, width: self.frame.size.width, height: 20))
    //distanceLabel?.backgroundColor = UIColor(white: 0.3, alpha: 0.7)
    distanceLabel?.textColor = UIColor.green
    distanceLabel?.font = UIFont.systemFont(ofSize: 12)
    self.addSubview(distanceLabel!)
    
    if let annotation = annotation as? Place {
      titleLabel?.text = annotation.placeName
      distanceLabel?.text = String(format: "%.2f km", annotation.distanceFromUser / 1000)
    }
  }
  
  //1
  override func layoutSubviews() {
    super.layoutSubviews()
    logoView?.frame = CGRect(x: 10, y: 10, width: 35, height: 35)
    titleLabel?.frame = CGRect(x: 48, y: 6, width: self.frame.size.width, height: 25)
    distanceLabel?.frame = CGRect(x: 48, y: 25, width: self.frame.size.width, height: 20)
  }
    
  //2
  override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
    delegate?.didTouch(annotationView: self)
  }

}

