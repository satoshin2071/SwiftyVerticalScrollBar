//
//  SwiftyVerticalScrollBar.swift
//  SwiftyVerticalScrollBar
//


import Foundation
import UIKit
import QuartzCore

open class SwiftyVerticalScrollBar : UIControl {
    
    //-------------------------
    // MARK: - stored property
    //-------------------------
    
    fileprivate (set) var targetScrollView :UIScrollView
    
    fileprivate (set) var isHandleDragged = false
    
    fileprivate (set) var handleHitArea = CGRect.zero
    
    fileprivate (set) var lastTouchLocation = CGPoint.zero
    
    fileprivate let handleWidth : CGFloat = 5.0
    
    fileprivate let handleSelectedWidth : CGFloat = 15.0
    
    fileprivate let handleHitWidth : CGFloat = 44.0
    
    fileprivate let handleMinimumHeight : CGFloat = 70.0
    
    //---------------------------
    // MARK: - computed property
    //---------------------------
    
    fileprivate var _handleLayer = CALayer()
    fileprivate var handleLayer : CALayer {
        get {
            return _handleLayer
        }
        set {
            _handleLayer.cornerRadius = self.handleCornerRadius
            _handleLayer.anchorPoint = CGPoint(x: 1.0, y: 0)
            _handleLayer.frame = CGRect(x: 0, y: 0, width: self.handleWidth, height: 0)
            _handleLayer.backgroundColor = self.normalColor.cgColor
        }
    }
    
    fileprivate var handleCornerRadius : CGFloat {
        return self.handleWidth * 0.5
    }
    
    fileprivate var handleSelectedCornerRadius : CGFloat {
        return self.handleSelectedWidth * 0.5
    }
    
    fileprivate var isHandleVisible : Bool {
        return self.handleLayer.opacity == 1.0
    }
    
    fileprivate var contentHeight : CGFloat {
        return self.targetScrollView.contentSize.height
    }
    
    fileprivate var frameHeight : CGFloat {
        return self.targetScrollView.frame.size.height
    }
    
    /// Calculate the current scroll value
    fileprivate var currentScrollValue : CGFloat {
        return (self.contentHeight - self.frameHeight == 0) ? 0
            : self.targetScrollView.contentOffset.y / (self.contentHeight - self.frameHeight);
    }
    
    /// Set the handleHeight that is proportional to the contentHeight
    fileprivate var handleHeight : CGFloat {
        return SwiftyVerticalScrollBar.CLAMP((self.frameHeight / self.contentHeight) * bounds.size.height, low:self.handleMinimumHeight , high:bounds.size.height )
    }
    
    fileprivate var handlePreviousWidth : CGFloat {
        return self.handleLayer.bounds.size.width > 0 ? self.handleLayer.bounds.size.width : self.handleWidth;
    }
    
    //----------------------
    // MARK: - initializers
    //----------------------
    
    public init(frame:CGRect, targetScrollView:UIScrollView) {
        self.targetScrollView = targetScrollView
        super.init(frame: frame)
        self.setup()
    }
    
    @available (*, unavailable, message: "Let's use the init(identifier) instead")
    required public init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setup() {
        self.handleLayer = CALayer()
        self.layer.addSublayer(self.handleLayer)
        
        self.targetScrollView.addObserver(self, Key: .contentOffset)
        self.targetScrollView.addObserver(self, Key: .contentSize)
        
        self.setNeedsLayout()
    }
    
    deinit {
        self.targetScrollView.removeObserver(self, Key: .contentOffset)
        self.targetScrollView.removeObserver(self, Key: .contentSize)
    }
    
    override open func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
        guard (object as? UIScrollView) == self.targetScrollView else {
            return
        }
        
        self.setNeedsLayout()
    }
    
    //----------------------
    // MARK: - layout
    //----------------------
    
    override open func layoutSubviews() {
        super.layoutSubviews()
        
        guard self.contentHeight >= self.frameHeight else {
            handleLayer.opacity = 0
            return
        }
        
        CATransaction.begin()
        CATransaction.setDisableActions(true)
        
        let bounds = self.bounds
        let scrollValue = self.currentScrollValue
        let handleHeight = self.handleHeight
        
        self.handleLayer.opacity = (handleHeight == bounds.size.height) ? 0 : 1
        
        // ScrollValue is such that the handle when approaching the 1 do not go out of the screen, to map the position not only move the handle
        let handleY : CGFloat = SwiftyVerticalScrollBar.CLAMP((scrollValue * bounds.size.height) - (scrollValue * handleHeight), low: 0, high: bounds.size.height - handleHeight)
        
        self.handleLayer.position = CGPoint(x: bounds.size.width, y: handleY)
        self.handleLayer.bounds = CGRect(x: 0, y: 0, width: self.handlePreviousWidth, height: handleHeight)
        self.handleHitArea = CGRect(x: bounds.size.width - self.handleHitWidth, y: handleY,
                                    width: self.handleHitWidth, height: handleHeight);
        
        CATransaction.commit()
    }
    
    fileprivate func handleTransform(expand:Bool) {
        
        guard self.isHandleVisible else{
            return
        }
        
        CATransaction.begin()
        CATransaction.setAnimationDuration(0.3)
        
        if (expand) {
            self.handleLayer.cornerRadius = self.handleSelectedCornerRadius
            self.handleLayer.bounds = CGRect(x: 0, y: 0, width: self.handleSelectedWidth, height: self.handleLayer.bounds.size.height)
            self.handleLayer.backgroundColor = self.selectedColor.cgColor
        } else {
            self.handleLayer.cornerRadius = self.handleCornerRadius
            self.handleLayer.bounds = CGRect(x: 0, y: 0, width: self.handleWidth, height: self.handleLayer.bounds.size.height)
            self.handleLayer.backgroundColor = self.normalColor.cgColor
        }
        
        CATransaction.commit()
    }
    
    //----------------------------------
    // MARK: - override UIControl method
    //----------------------------------
    
    override open func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        
        guard self.isHandleVisible else{
            return false
        }
        
        self.lastTouchLocation = touch.location(in: self)
        self.isHandleDragged = true
        self.handleTransform(expand: true)
        
        self.setNeedsLayout()
        
        return true
    }
    
    override open func continueTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        
        let touchLocation = touch.location(in: self)
        
        let contentSize = self.targetScrollView.contentSize
        let contentOffset = self.targetScrollView.contentOffset
        let frameHeight = self.targetScrollView.frame.size.height
        let deltaY : CGFloat = ((touchLocation.y - self.lastTouchLocation.y) / self.bounds.size.height) * contentSize.height
        
        let offsetY = SwiftyVerticalScrollBar.CLAMP(contentOffset.y+deltaY, low: 0, high: contentSize.height - frameHeight)
        
        self.targetScrollView.setContentOffset(CGPoint(x: contentOffset.x, y: offsetY), animated: false)
        self.lastTouchLocation = touchLocation
        
        return true
    }
    
    override open func endTracking(_ touch: UITouch?, with event: UIEvent?) {
        self.lastTouchLocation = CGPoint.zero
        self.isHandleDragged = false
        self.handleTransform(expand: false)
    }
    
}

//----------------------
// MARK: - extension
//----------------------

private extension SwiftyVerticalScrollBar {
    
    var normalColor : UIColor {
        return UIColor(white: 0.6, alpha: 1.0)
    }
    
    var selectedColor : UIColor {
        return UIColor(white: 0.4, alpha: 1.0)
    }
    
    static func CLAMP(_ value:CGFloat,low:CGFloat,high:CGFloat) -> CGFloat {
        if value > high {
            return high
        }else if low > value {
            return low
        }else{
            return value
        }
    }
}

protocol Keycodable {
    associatedtype ObserverKeys : RawRepresentable
}

extension UIScrollView : Keycodable {
    
    var KVOOptions : NSKeyValueObservingOptions {
        return NSKeyValueObservingOptions([.new, .old, .prior])
    }
    
    enum ObserverKeys : String {
        case contentOffset
        case contentSize
    }
    
    func addObserver(_ observer: NSObject, Key key: ObserverKeys) {
        self.addObserver(observer, forKeyPath: key.rawValue , options: KVOOptions, context: nil)
    }
    
    func removeObserver(_ observer: NSObject, Key key: ObserverKeys) {
        self.removeObserver(observer, forKeyPath: key.rawValue, context: nil)
    }
}
