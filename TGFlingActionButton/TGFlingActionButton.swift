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
    private var rightImage:UIImageView?
    private var progress_line:UIView?
    
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
    
    @IBInspectable var ProgressLine: UIColor?  {
        didSet {
            self.progress_line?.backgroundColor = ProgressLine!
        }
    }
    
    @IBInspectable var CornerRadius: CGFloat = 0.0  {
        didSet {
            self.layer.cornerRadius = CornerRadius
        }
    }
    
    @IBInspectable var SwipableLayerCornerRadius: CGFloat = 0.0   {
        didSet {
            swipableView?.layer.cornerRadius = SwipableLayerCornerRadius
        }
    }
    
    
    
    
    override func draw(_ rect: CGRect) {
        
        progress_line = UIView.init(frame: CGRect(x: 5, y: (self.frame.size.height/2) - 1, width: self.frame.size.width-10, height: 2))
        progress_line!.backgroundColor = UIColor.gray
        self.addSubview(progress_line!)
        
        if self.swipableView == nil {
            self.addSubview(self.setSwipableLayer())
        }
        super.draw(rect)
    }
    
    
    func setSwipableLayer() -> UIView {
        
        swipableView = UILabel.init(frame: CGRect(x: 15 , y: (self.frame.size.height/2) - 25, width: 120, height: 50))
        swipableView?.isUserInteractionEnabled = true
        swipableView?.textAlignment = .left
        swipableView?.tag = 1020
        swipableView?.textColor = self.titleColor(for: UIControl.State.normal)
        swipableView?.backgroundColor = UIColor.orange
        swipableView?.layer.cornerRadius = SwipableLayerCornerRadius
        swipableView?.text = "Proceed"
        swipableView?.font = UIFont.boldSystemFont(ofSize: 16.0)
        swipableView?.clipsToBounds = true
        
        
        
        rightImage = UIImageView.init(image: UIImage.init(named: "WhiteRightArrow"))
        rightImage!.frame = CGRect(x: swipableView!.frame.size.width - 45 , y: 5, width: 40, height: 40)
        rightImage!.isUserInteractionEnabled = true
        rightImage!.backgroundColor = UIColor.clear
        rightImage!.contentMode = UIView.ContentMode.scaleAspectFill
        rightImage?.clipsToBounds = true
        swipableView!.addSubview(rightImage!)
        
        
        panGestureR = UIPanGestureRecognizer.init(target: self, action: #selector(handelPanGesture(panGesture:)))
        swipableView!.addGestureRecognizer(panGestureR!)
        
        return swipableView!
    }
    
    
    @objc func handelPanGesture(panGesture: UIPanGestureRecognizer) {
        
        let translation = panGesture.translation(in: panGesture.view?.superview)
        
        if translation.x >= 0 {
            if self.swipe_direction == .none {
                self.swipe_direction = self.getSwipeDirection(translation: translation)
            }
            if self.swipe_direction == .right {
                self.setTitle("", for: UIControl.State.normal)
                if panGesture.state == UIGestureRecognizer.State.ended {
                    let x:Int = Int(translation.x)
                    if  x > Int(self.frame.size.width-150) {
                        UIView.animate(withDuration: 0.2, animations: {
                            self.swipableView!.frame = CGRect(x:((self.progress_line?.frame.size.width)!-117), y: (self.frame.size.height/2) - 25, width: (self.swipableView?.frame.size.width)!, height: (self.swipableView?.frame.size.height)!)
                            self.swipableView?.backgroundColor = self.FinalStateColor
                        })
                        
                        self.sendActions(for: .valueChanged)
                        self.swipe_direction = .none
                        
                    }else{
                        UIView.animate(withDuration: 0.2, animations: {
                            self.swipableView!.frame = CGRect(x:15, y: (self.frame.size.height/2) - 25, width: (self.swipableView?.frame.size.width)!, height: (self.swipableView?.frame.size.height)!)
                            
                        })
                    }
                }else{
                    if Int(translation.x) > Int(self.frame.size.width-125) {
                        return
                    }
                    UIView.animate(withDuration: 0.0) {
                        self.swipableView!.frame = CGRect(x: (translation.x) , y: (self.frame.size.height/2) - 25, width: (self.swipableView?.frame.size.width)!, height: (self.swipableView?.frame.size.height)!)
                    }
                    
                }
            }
        }
//        }else{
//            UIView.animate(withDuration: 0.2, animations: {
//                self.swipableView!.frame = CGRect(x:15, y: (self.frame.size.height/2) - 25, width: (self.swipableView?.frame.size.width)!, height: (self.swipableView?.frame.size.height)!)
//                self.swipableView?.backgroundColor = UIColor.orange
//
//            })
//
//            if self.swipe_direction == .none {
//                self.swipe_direction = self.getSwipeDirection(translation: translation)
//            }
//            if self.swipe_direction == .left{
//                self.swipableView?.text = ""
//                if panGesture.state == UIGestureRecognizer.State.ended {
//                    let x:Int = Int(translation.x)
//                    if  x < Int(100 - self.frame.size.width) {
//                        UIView.animate(withDuration: 0.2, animations: {
//                            self.swipableView!.frame = CGRect(x:(0-self.frame.size.width) + self.frame.size.height, y: 0, width: (self.swipableView?.frame.size.width)!, height: (self.swipableView?.frame.size.height)!)
//                            self.swipableView?.backgroundColor = self.InitialStateColor
//                            //                            self.setTitle("START RIDE", for: UIControl.State.normal)
//                            //                            self.backgroundColor = self.green_color
//
//                        })
//                        self.sendActions(for: .valueChanged)
//                        self.swipe_direction = .none
//                    }else{
//                        UIView.animate(withDuration: 0.2, animations: {
//                            self.swipableView!.frame = CGRect(x:0, y: 0, width: (self.swipableView?.frame.size.width)!, height: (self.swipableView?.frame.size.height)!)
//                            self.swipableView?.text = "END RIDE"
//                        })
//                    }
//                }else{
//                    swipableView!.frame = CGRect(x: translation.x, y: 0, width: (swipableView?.frame.size.width)!, height: (swipableView?.frame.size.height)!)
//                }
//            }
//
//        }
        
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
