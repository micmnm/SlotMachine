//
//  ViewController.swift
//  SlotMachine
//
//  Created by mircea on 12/27/14.
//  Copyright (c) 2014 mltru. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var firstContainer:UIView!
    var secondContainer:UIView!
    var thridContainer:UIView!
    var fourthContainer:UIView!
    
    var titleLabel:UILabel!
    
    let cMarginForView:CGFloat = 10.0
    let cMarginForSlot:CGFloat = 2.0
    
    let cSixth:CGFloat = 1.0/6.0
    let cNumberOfContainers = 3
    let cNumberOfSlots = 3
    let cThird:CGFloat = 1.0/3.0

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        setupContainerViews()
        setupFirstContainer(self.firstContainer)
        setupSecondContainer(self.secondContainer)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    // Setups containers
    func setupContainerViews() {
        self.firstContainer = UIView(frame: CGRect(
            x: self.view.bounds.origin.x + cMarginForView,
            y: self.view.bounds.origin.y,
            width: self.view.bounds.width - (cMarginForView * 2),
            height: self.view.bounds.height * cSixth))
        self.firstContainer.backgroundColor = UIColor.redColor()
        self.view.addSubview(self.firstContainer)
        
        self.secondContainer = UIView(frame: CGRect(
            x: self.view.bounds.origin.x + cMarginForView,
            y: firstContainer.frame.height,
            width: self.view.bounds.width - (cMarginForView * 2),
            height: self.view.bounds.height * ( 3 * cSixth)))
        self.secondContainer.backgroundColor = UIColor.blackColor()
        self.view.addSubview(self.secondContainer)
        
        self.thridContainer = UIView(frame: CGRect(
            x: self.view.bounds.origin.x + cMarginForView,
            y: firstContainer.frame.height + secondContainer.frame.height,
            width: self.view.bounds.width - (cMarginForView * 2),
            height: self.view.bounds.height * cSixth))
        self.thridContainer.backgroundColor = UIColor.lightGrayColor()
        self.view.addSubview(self.thridContainer)
        
        self.fourthContainer = UIView(frame: CGRect(
            x: self.view.bounds.origin.x + cMarginForView,
            y: firstContainer.frame.height + secondContainer.frame.height + thridContainer.frame.height,
            width: self.view.bounds.width - (cMarginForView * 2),
            height: self.view.bounds.height * cSixth))
        self.fourthContainer.backgroundColor = UIColor.blackColor()
        self.view.addSubview(self.fourthContainer)
    }
    
    // First container
    func setupFirstContainer(containerView:UIView) {
        self.titleLabel = UILabel()
        self.titleLabel.text = "Super Slots"
        self.titleLabel.textColor = UIColor.yellowColor()
        self.titleLabel.font = UIFont(name: "MarkerFelt-Wide", size: 40)
        self.titleLabel.sizeToFit()
        self.titleLabel.center = containerView.center
        containerView.addSubview(self.titleLabel)
    }
    
    // Second container
    func setupSecondContainer(containerView: UIView) {
        // Build slots
        
        var slotWidth = (containerView.bounds.width * cThird)
        var slotHeight = (containerView.bounds.height * cThird)
        
        for var containerNumber = 0; containerNumber < cNumberOfContainers; ++containerNumber {
            for var slotNumber = 0; slotNumber < cNumberOfSlots; ++slotNumber {
                var slotImageView = UIImageView()
                slotImageView.backgroundColor = UIColor.yellowColor()
                slotImageView.frame = CGRect(
                    x: containerView.bounds.origin.x + (CGFloat(containerNumber) * containerView.bounds.width * cThird),
                    y: containerView.bounds.origin.y + (CGFloat(slotNumber) * containerView.bounds.height * cThird),
                    width: containerView.bounds.width * cThird - cMarginForSlot,
                    height: containerView.bounds.height * cThird - cMarginForSlot)
                slotImageView.backgroundColor = UIColor.orangeColor()
                containerView.addSubview(slotImageView)
                
            }
        }
    }
    
}

