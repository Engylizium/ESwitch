//
//  customSwitch.swift
//  GeckoVR
//
//  Created by Engylizium on 02.04.17.
//  Copyright © 2017 Ltd. Gecko Technology. All rights reserved.
//

import UIKit

@IBDesignable open class ESwitch: UIControl {
    
    @IBInspectable var height: CGFloat = 30 {
        didSet { if oldValue != height { update() } }
    }
    var width: CGFloat = 1
    
    @IBInspectable var widthScale: CGFloat = 1.8 {
        didSet { if oldValue != widthScale { update() } }
    }
    
    var size = CGSize()
    
    var thumb: UIView!
    @IBInspectable var isRounded: Bool = false {
        didSet { if oldValue != isRounded { update() } }
    }
    @IBInspectable var thumbHeight: CGFloat = 10 {
        didSet { if oldValue != thumbHeight || thumbHeight < height { update() }
        else if oldValue > height { thumbHeight = height } }
    }
    @IBInspectable var thumbColor: UIColor = UIColor.red {
        didSet { if oldValue != thumbColor { update() } }
    }
    @IBInspectable var thumbBorderColor: UIColor = UIColor.lightGray {
        didSet { if oldValue != thumbBorderColor { update() } }
    }
    @IBInspectable var thumbBorderWidth: CGFloat = 1 {
        didSet { if oldValue != thumbBorderWidth { update() } }
    }
    
    var switchFrame: UIView!
    @IBInspectable var switchInnerColor: UIColor = UIColor.clear {
        didSet { if oldValue != switchInnerColor { update() } }
    }
    @IBInspectable var switchBorderColor: UIColor = UIColor.lightGray {
        didSet { if oldValue != switchBorderColor { update() } }
    }
    @IBInspectable var switchFrameCornerRadius: CGFloat = 0 {
        didSet { if oldValue != switchFrameCornerRadius { update() } }
    }
    @IBInspectable var switchFrameWidth: CGFloat = 1 {
        didSet { if oldValue != switchFrameWidth { update() } }
    }
    
    var innerView: UIView!
    @IBInspectable var changeInnerHeight: Bool = false {
        didSet { if oldValue != changeInnerHeight { update() } }
    }
    @IBInspectable var innerHeight: CGFloat = 15 {
        didSet { if oldValue != innerHeight { update() } }
    }
    @IBInspectable var innerColor: Bool = false {
        didSet { if oldValue != innerColor { update() } }
    }
    @IBInspectable var innerOnColor: UIColor = UIColor.green {
        didSet { if oldValue != innerOnColor { update() } }
    }
    
    func createThumb() -> UIView {
        let thumb = UIView(frame: CGRect(origin: CGPoint(), size: CGSize(width: thumbHeight, height: thumbHeight)))
        if isSelected {
            if thumbHeight > switchFrame.frame.height {
                thumb.center = CGPoint(x: size.width - thumbHeight/2, y: thumbHeight/2)
            } else {
                thumb.center = CGPoint(x: size.width - thumbHeight/2, y: size.height/2)
            }
        } else {
            if thumbHeight > switchFrame.frame.height {
                thumb.center = CGPoint(x: thumbHeight/2, y: thumbHeight/2)
            } else {
                thumb.center = CGPoint(x: thumbHeight/2, y: size.height/2)
            }
        }
        if isRounded {
            thumb.layer.cornerRadius = thumb.frame.height / 2
        } else {
            thumb.layer.cornerRadius = switchFrameCornerRadius
        }
        thumb.backgroundColor = thumbColor
        thumb.layer.borderColor = thumbBorderColor.cgColor
        thumb.layer.borderWidth = thumbBorderWidth
        thumb.isUserInteractionEnabled = false
        return thumb
    }
    
    func createInnerView() -> UIView {
        let innerView = UIView(frame: CGRect(origin: switchFrame.frame.origin, size: CGSize()))
        if isSelected {
            if changeInnerHeight {
                innerView.frame = CGRect(x: 0, y: 0, width: size.width, height: innerHeight)
                if thumbHeight < switchFrame.frame.height {
                    innerView.center = CGPoint(x: 0, y: switchFrame.frame.height/2)
                } else {
                    innerView.center = CGPoint(x: 0, y: thumbHeight/2)
                }
            } else {
                innerView.frame = switchFrame.frame
            }
        } else {
            if changeInnerHeight {
                innerView.frame = CGRect(x: 0, y: 0, width: 0, height: innerHeight)
                if thumbHeight < switchFrame.frame.height {
                    innerView.center = CGPoint(x: 0, y: switchFrame.frame.height/2)
                } else {
                    innerView.center = CGPoint(x: 0, y: thumbHeight/2)
                }
            } else {
                innerView.frame = CGRect(origin: switchFrame.frame.origin, size: CGSize(width: 0, height: switchFrame.frame.height))
            }
        }
        if isRounded {
            innerView.layer.cornerRadius = innerView.frame.height / 2
        } else {
            innerView.layer.cornerRadius = switchFrameCornerRadius
        }
        innerView.backgroundColor = innerOnColor
        innerView.isUserInteractionEnabled = false
        return innerView
    }
    
    func createFrame() -> UIView {
        let switchFrame = UIView(frame: CGRect(origin: CGPoint(x: 0, y: 0), size: size))
        if thumbHeight > switchFrame.frame.height {
            switchFrame.center = CGPoint(x: size.width/2, y: thumbHeight/2)
        }
        if isRounded {
            switchFrame.layer.cornerRadius = switchFrame.frame.height / 2
        } else {
            switchFrame.layer.cornerRadius = switchFrameCornerRadius
        }
        switchFrame.backgroundColor = switchInnerColor
        switchFrame.layer.borderWidth = switchFrameWidth
        switchFrame.layer.borderColor = switchBorderColor.cgColor
        switchFrame.isUserInteractionEnabled = false
        return switchFrame
    }
    
    func animate() {
        if isSelected {
            UIView.animate(withDuration: 0.5, animations: {
// Change thumb Position
                if self.thumbHeight > self.switchFrame.frame.height {
                    self.thumb.center = CGPoint(x: self.size.width - self.thumbHeight/2, y: self.thumbHeight/2)
                } else {
                    self.thumb.center = CGPoint(x: self.size.width - self.thumbHeight/2, y: self.size.height/2)
                }
// Change innerView Position
                if self.innerColor {
                if self.changeInnerHeight {
                    self.innerView.frame.size = CGSize(width: self.size.width, height: self.innerHeight)
                } else {
                    self.innerView.frame.size = CGSize(width: self.size.width, height: self.size.height)
                }
                }
            })
        } else {
            UIView.animate(withDuration: 0.5, animations: {
// Change thumb Position
                if self.thumbHeight > self.switchFrame.frame.height {
                    self.thumb.center = CGPoint(x: self.thumbHeight/2, y: self.thumbHeight/2)
                } else {
                    self.thumb.center = CGPoint(x: self.thumbHeight/2, y: self.size.height/2)
                }
// Cgange innerView Position
                if self.innerColor {
                if self.changeInnerHeight {
                    self.innerView.frame.size = CGSize(width: 0, height: self.innerHeight)
                } else {
                    self.innerView.frame.size = CGSize(width: 0, height: self.size.height)
                }
                }
            })
        }
    }
    
    func update() {
        size = CGSize(width: height * widthScale, height: height)
        self.subviews.forEach({$0.removeFromSuperview()})
        switchFrame = createFrame()
        thumb = createThumb()
        if innerColor {
        innerView = createInnerView()
        }
        if innerColor {
        self.addSubview(innerView)
        }
        self.addSubview(switchFrame)
        self.addSubview(thumb)
        self.addTarget(self, action: #selector(handleTouchUpInside), for: UIControlEvents.touchUpInside)
    }
    
    func handleTouchUpInside() {
        self.isSelected = !isSelected
        animate()
        self.sendActions(for: UIControlEvents.valueChanged)
    }
    
    open override var intrinsicContentSize: CGSize {
        return size
    }

    open override func awakeFromNib() {
        super.awakeFromNib()
        update()
    }
    
    public convenience init() {
        self.init(frame: CGRect())
        update()
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        update()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        update()
    }
}
