//
//  ViewController.swift
//  SlotMachine
//
//  Created by mircea on 12/27/14.
//  Copyright (c) 2014 mltru. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var firstContainer: UIView!
    var secondContainer: UIView!
    var thridContainer: UIView!
    var fourthContainer: UIView!
    
    var titleLabel: UILabel!
    
    // Information labels
    var creditsLabel: UILabel!
    var betLabel: UILabel!
    var winnerPaidLabel: UILabel!
    var creditsTitleLabel: UILabel!
    var betTitleLabel: UILabel!
    var winnerPaidTitleLabel: UILabel!
    
    // Action Buttons in Fourth container
    var resetButton: UIButton!
    var betOneButton: UIButton!
    var betMaxButton: UIButton!
    var spinButton: UIButton!
    
    var slots:[[Slot]] = []
    
    // Game stats
    var credits = 0
    var currentBet = 0
    var winnings = 0
    
    let cMarginForView:CGFloat = 10.0
    let cMarginForSlot:CGFloat = 2.0
    
    let cSixth:CGFloat = 1.0/6.0
    let cNumberOfContainers = 3
    let cNumberOfSlots = 3
    let cThird:CGFloat = 1.0/3.0
    
    let cHalf:CGFloat = 1.0/2.0
    let cEighth:CGFloat = 1.0/8.0

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        setupContainerViews()
        setupFirstContainer(self.firstContainer)
        setupThirdContainer(self.thridContainer)
        setupFourthContainer(self.fourthContainer)
        hardReset()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // IBActions
    func resetButtonPressed(button: UIButton) {
        hardReset()
    }
    
    func betOneButtonPressed(button: UIButton) {
        if (credits < 1) {
            showAlertWithText(header: "No more credits", message: "Reset game")
        } else {
            if (currentBet < 5) {
                currentBet += 1
                updateMainView()
            }
            else {
                showAlertWithText(message: "You can only bet 5 most")
            }
        }
    }
    
    func betMaxButtonPressed(button: UIButton) {
        if (credits <= 5) {
            showAlertWithText(header: "Not enough credits", message: "Bet less")
        } else {
            if (currentBet < 5) {
                var creditsToBetMax = 5 - currentBet
                credits -= creditsToBetMax
                currentBet += creditsToBetMax
                updateMainView()
            } else {
                showAlertWithText(message: "You can only bet 5 most")
            }
        }
    }
    
    func spinButtonPressed(button: UIButton) {
        removeSlotImageViews()
        slots = Factory.createSlots()
        setupSecondContainer(self.secondContainer)
        
        var winMultiplier = SlotBrain.computeWinnings(slots)
        winnings = winMultiplier * currentBet
        credits += winnings
        updateMainView()
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
    func setupFirstContainer(containerView: UIView) {
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
                
                var slot:Slot
                var slotImageView = UIImageView()
                
                if slots.count != 0 {
                    let slotContainer = slots[containerNumber]
                    slot = slotContainer[slotNumber]
                    slotImageView.image = slot.image
                } else {
                    slotImageView.image = UIImage(named: "Ace")
                }
                
                // slotImageView.backgroundColor = UIColor.yellowColor()
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
    
    // Third container
    func setupThirdContainer(contaierView: UIView) {
        let cFontName = "Menlo-Bold"
        let cFontSize:CGFloat = 16
        let cFontTitleName = "AmericanTypeWriter"
        let cFontTitleSize:CGFloat = 14
        
        self.creditsLabel = UILabel()
        self.creditsLabel.text = "000"
        self.creditsLabel.textColor = UIColor.redColor()
        self.creditsLabel.font = UIFont(name: cFontName, size: cFontSize)
        self.creditsLabel.sizeToFit()
        self.creditsLabel.center = CGPoint(x: contaierView.frame.width * cSixth, y: contaierView.frame.height * cThird)
        self.creditsLabel.textAlignment = NSTextAlignment.Center
        self.creditsLabel.backgroundColor = UIColor.darkGrayColor()
        contaierView.addSubview(self.creditsLabel)
        
        self.betLabel = UILabel()
        self.betLabel.text = "0000"
        self.betLabel.textColor = UIColor.redColor()
        self.betLabel.font = UIFont(name: cFontName, size: cFontSize)
        self.betLabel.sizeToFit()
        self.betLabel.center = CGPoint(x: contaierView.frame.width * cSixth * 3, y: contaierView.frame.height * cThird)
        self.betLabel.textAlignment = NSTextAlignment.Center
        self.betLabel.backgroundColor = UIColor.darkGrayColor()
        contaierView.addSubview(self.betLabel)
        
        self.winnerPaidLabel = UILabel()
        self.winnerPaidLabel.text = "000000"
        self.winnerPaidLabel.textColor = UIColor.redColor()
        self.winnerPaidLabel.font = UIFont(name: cFontName, size: cFontSize)
        self.winnerPaidLabel.sizeToFit()
        self.winnerPaidLabel.center = CGPoint(x: contaierView.frame.width * cSixth * 5, y: contaierView.frame.height * cThird)
        self.winnerPaidLabel.textAlignment = NSTextAlignment.Center
        self.winnerPaidLabel.backgroundColor = UIColor.darkGrayColor()
        contaierView.addSubview(self.winnerPaidLabel)
        
        self.creditsTitleLabel = UILabel()
        self.creditsTitleLabel.text = "Credits"
        self.creditsTitleLabel.textColor = UIColor.blackColor()
        self.creditsTitleLabel.font = UIFont(name: cFontTitleName, size: cFontTitleSize)
        self.creditsTitleLabel.sizeToFit()
        self.creditsTitleLabel.center = CGPoint(x: contaierView.frame.width * cSixth, y: contaierView.frame.height * cThird * 2)
        self.creditsTitleLabel.textAlignment = NSTextAlignment.Center
        contaierView.addSubview(self.creditsTitleLabel)
        
        self.betTitleLabel = UILabel()
        self.betTitleLabel.text = "Bet"
        self.betTitleLabel.textColor = UIColor.blackColor()
        self.betTitleLabel.font = UIFont(name: cFontTitleName, size: cFontTitleSize)
        self.betTitleLabel.sizeToFit()
        self.betTitleLabel.center = CGPoint(x: contaierView.frame.width * cSixth * 3, y: contaierView.frame.height * cThird * 2)
        self.betTitleLabel.textAlignment = NSTextAlignment.Center
        contaierView.addSubview(self.betTitleLabel)
        
        self.winnerPaidTitleLabel = UILabel()
        self.winnerPaidTitleLabel.text = "Winner Paid"
        self.winnerPaidTitleLabel.textColor = UIColor.blackColor()
        self.winnerPaidTitleLabel.font = UIFont(name: cFontTitleName, size: cFontTitleSize)
        self.winnerPaidTitleLabel.sizeToFit()
        self.winnerPaidTitleLabel.center = CGPoint(x: contaierView.frame.width * cSixth * 5, y: contaierView.frame.height * cThird * 2)
        self.winnerPaidTitleLabel.textAlignment = NSTextAlignment.Center
        contaierView.addSubview(self.winnerPaidTitleLabel)
    }
    
    // Fourth container
    func setupFourthContainer(containerView: UIView) {
        let cFontName = "Superclarendon-Bold"
        let cFontSize:CGFloat = 12
        
        self.resetButton = UIButton()
        self.resetButton.setTitle("Reset", forState: UIControlState.Normal)
        self.resetButton.setTitleColor(UIColor.blueColor(), forState: UIControlState.Normal)
        self.resetButton.titleLabel?.font = UIFont(name: cFontName, size: cFontSize)
        self.resetButton.backgroundColor = UIColor.lightGrayColor()
        self.resetButton.sizeToFit()
        self.resetButton.center = CGPoint(x: containerView.frame.width * cEighth, y: containerView.frame.height * cHalf)
        self.resetButton.addTarget(self, action: "resetButtonPressed:", forControlEvents: UIControlEvents.TouchUpInside)
        containerView.addSubview(self.resetButton)
        
        self.betOneButton = UIButton()
        self.betOneButton.setTitle("Bet One", forState: UIControlState.Normal)
        self.betOneButton.setTitleColor(UIColor.blueColor(), forState: UIControlState.Normal)
        self.betOneButton.titleLabel?.font = UIFont(name: cFontName, size: cFontSize)
        self.betOneButton.backgroundColor = UIColor.greenColor()
        self.betOneButton.sizeToFit()
        self.betOneButton.center = CGPoint(x: containerView.frame.width * cEighth * 3, y: containerView.frame.height * cHalf)
        self.betOneButton.addTarget(self, action: "betOneButtonPressed:", forControlEvents: UIControlEvents.TouchUpInside)
        containerView.addSubview(self.betOneButton)
        
        self.betMaxButton = UIButton()
        self.betMaxButton.setTitle("Bet Max", forState: UIControlState.Normal)
        self.betMaxButton.setTitleColor(UIColor.blueColor(), forState: UIControlState.Normal)
        self.betMaxButton.titleLabel?.font = UIFont(name: cFontName, size: cFontSize)
        self.betMaxButton.backgroundColor = UIColor.greenColor()
        self.betMaxButton.sizeToFit()
        self.betMaxButton.center = CGPoint(x: containerView.frame.width * cEighth * 5, y: containerView.frame.height * cHalf)
        self.betMaxButton.addTarget(self, action: "betMaxButtonPressed:", forControlEvents: UIControlEvents.TouchUpInside)
        containerView.addSubview(self.betMaxButton)
        
        self.spinButton = UIButton()
        self.spinButton.setTitle("Spin", forState: UIControlState.Normal)
        self.spinButton.setTitleColor(UIColor.blueColor(), forState: UIControlState.Normal)
        self.spinButton.titleLabel?.font = UIFont(name: cFontName, size: cFontSize)
        self.spinButton.backgroundColor = UIColor.greenColor()
        self.spinButton.sizeToFit()
        self.spinButton.center = CGPoint(x: containerView.frame.width * cEighth * 7, y: containerView.frame.height * cHalf)
        self.spinButton.addTarget(self, action: "spinButtonPressed:", forControlEvents: UIControlEvents.TouchUpInside)
        containerView.addSubview(self.spinButton)
    }
    
    func removeSlotImageViews() {
        let container:UIView? = self.secondContainer //!
        let subViews:Array? = container!.subviews
        for view in subViews! {
            view.removeFromSuperview()
        }
    }
    
    func hardReset() {
        removeSlotImageViews()
        slots.removeAll(keepCapacity: true)
        self.setupSecondContainer(self.secondContainer)
        credits = 50
        winnings = 0
        currentBet = 0
        updateMainView()
    }
    
    func updateMainView() {
        self.creditsLabel.text = "\(credits)"
        self.betLabel.text = "\(currentBet)"
        self.winnerPaidLabel.text = "\(winnings)"
    }
    
    func showAlertWithText(header: String = "Warning", message: String) {
        var alert = UIAlertController(title: header, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
}

