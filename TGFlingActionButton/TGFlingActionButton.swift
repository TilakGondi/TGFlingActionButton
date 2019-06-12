//
//  TGFlingActionButton.swift
//  TGFlingActionButton
//
//  Created by Tilakkumar Gondi on 23/05/19.
//  Copyright © 2019 Tilakkumar Gondi. All rights reserved.
//
//  MIT License
//
//  Copyright (c) 2019 Tilakkumar Gondi <tilak.gondi@gmail.com>
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.
//

import UIKit

class TGFlingActionButton: UIButton {

    
    private var panGestureR:UIPanGestureRecognizer?
    
    private var swipableView:UILabel?
    private var swipeOverlay:UIImageView?

    
    private(set) var swipe_direction:Swipe_Direction = .none
    
    
    enum Swipe_Direction {
        case right
        case left
        case none
    }
    
    @IBInspectable var InitialStateColor: UIColor? = UIColor(red: 239.0/255.0, green: 82.0/255.0, blue: 45.0/255.0, alpha: 1.0) {
        didSet {
            self.InitialStateColor = InitialStateColor!
        }
    }
    
    @IBInspectable var FinalStateColor: UIColor? = UIColor(red: 0.0/255.0 , green: 138.0/255.0, blue: 62.0/255.0, alpha: 1.0) {
        didSet {
            self.FinalStateColor = FinalStateColor!
        }
    }
    
    @IBInspectable var ImageOverlay: UIImage?  {
        didSet {
            self.ImageOverlay = ImageOverlay!
        }
    }
    
    
    override func draw(_ rect: CGRect) {
        
        if self.swipableView == nil {
            self.addSubview(self.setSwipableLayer())
        }
        self.clipsToBounds = true
        super.draw(rect)
    }
    
    // To Add the swipable lable with pan-gesture enabled over the button
    func setSwipableLayer() -> UIView {
        self.layer.cornerRadius = self.frame.size.height/2
        
        swipableView = UILabel.init(frame: CGRect(x: 2 , y: 2, width: self.frame.size.height - 4, height: (self.frame.size.height - 4)))
        swipableView?.isUserInteractionEnabled = true
        swipableView?.textAlignment = .left
        swipableView?.tag = 1020
        swipableView?.textColor = self.titleColor(for: UIControl.State.normal)
        swipableView?.backgroundColor = UIColor.orange
        swipableView?.layer.cornerRadius = (swipableView?.frame.height)!/2
        swipableView?.font = UIFont.boldSystemFont(ofSize: 16.0)
        swipableView?.clipsToBounds = true
        
        
        if (ImageOverlay != nil) {
            swipeOverlay = UIImageView.init(image: ImageOverlay)
            swipeOverlay!.frame = CGRect(x: 2 , y: 2, width: (swipableView?.frame.width)! - 4, height: (swipableView?.frame.width)! - 4)
            swipeOverlay!.isUserInteractionEnabled = true
            swipeOverlay!.backgroundColor = UIColor.clear
            swipeOverlay!.contentMode = UIView.ContentMode.scaleAspectFill
            swipeOverlay?.clipsToBounds = true
            swipableView?.insertSubview(swipeOverlay!, at: 1)
        }
        
        
        panGestureR = UIPanGestureRecognizer.init(target: self, action: #selector(handelPanGesture(panGesture:)))
        swipableView!.addGestureRecognizer(panGestureR!)
        
        return swipableView!
    }
    
    
    @objc func handelPanGesture(panGesture: UIPanGestureRecognizer) {
        
        let translation = panGesture.translation(in: panGesture.view?.superview)
        let xPos:Int = Int(translation.x)
        let threshHoldX:Int = Int(self.frame.size.width - self.frame.size.height)
        if xPos >= 0 {
            if self.swipe_direction == .none {
                self.swipe_direction = self.getSwipeDirection(translation: translation)
            }
            
            if self.swipe_direction == .right {
                if Int((self.swipableView?.frame.origin.x)!) > threshHoldX {
                    //Ignore if the state is final.
                    return
                }
                
                if panGesture.state == UIGestureRecognizer.State.ended {
                    if  xPos > threshHoldX {
                        UIView.animate(withDuration: 0.2, animations: {
                            self.swipableView!.frame = CGRect(x:((self.frame.size.width)-(self.swipableView?.frame.size.width)! - 2), y: (self.swipableView?.frame.origin.y)!, width: (self.swipableView?.frame.size.width)!, height: (self.frame.size.height - 4))
                        })
                        UIView.animate(withDuration: 0.5) {
                            self.swipableView?.backgroundColor = self.FinalStateColor
                            self.swipeOverlay?.transform = (self.swipeOverlay?.transform.rotated(by: CGFloat(180.0 * .pi / 180.0)))!                        }
                        self.sendActions(for: .valueChanged)
                    }else {
                        UIView.animate(withDuration: 0.2, animations: {
                            self.swipableView!.frame = CGRect(x:2, y: (self.swipableView?.frame.origin.y)!, width: (self.swipableView?.frame.size.width)!, height: (self.frame.size.height - 4))
                        })
                    }
                }else{
                    if xPos > threshHoldX {
                        return
                    }
                    //To set the x position of the swipe lable layer to the gesture translation value.
                    UIView.animate(withDuration: 0.0) {
                        self.swipableView!.frame = CGRect(x: (translation.x) , y: (self.swipableView?.frame.origin.y)!, width: (self.swipableView?.frame.size.width)!, height: (self.frame.size.height - 4))
                    }
                    
                }
            }
        }
        
    }
    
    
    //To reset teh fling button to initial state.
    func reset() {
        UIView.animate(withDuration: 0.2, animations: {
            self.swipe_direction = .none
            self.swipableView!.frame = CGRect(x:2, y: (self.swipableView?.frame.origin.y)!, width: (self.swipableView?.frame.size.width)!, height: (self.frame.size.height - 4))
        })
        
        UIView.animate(withDuration: 0.5) {
            self.swipableView?.backgroundColor = self.InitialStateColor
            self.swipeOverlay?.transform = (self.swipeOverlay?.transform.rotated(by: CGFloat(180.0 * .pi / 180.0)))!
        }
    }
    
    
    func getSwipeDirection(translation:CGPoint) -> Swipe_Direction {
        
        if translation.x > 0 {
            return .right
        }else if translation.x < 0 {
            return .left
        }else{
            return .none
        }
        
    }
    
    override func sendActions(for controlEvents: UIControl.Event) {
        super.sendActions(for: controlEvents)
    }

}
