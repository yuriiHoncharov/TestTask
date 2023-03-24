//
//  Extension+UIView.swift
//  Dogiz
//
//  Created by Sasha Voloshanov on 05.04.2021.
//

import UIKit

extension UIView {
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
    /// Shake animation
    func shake(count: Float = 4, for duration: TimeInterval = 0.5, withTranslation translation: Float = 5) {
        let animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        animation.repeatCount = count
        animation.duration = duration / TimeInterval(animation.repeatCount)
        animation.autoreverses = true
        animation.values = [translation, -translation]
        layer.add(animation, forKey: "shake")
    }
    
    /// Scale animation
    func scale(timeInterval: TimeInterval = 0.5, sX: CGFloat = 1.1, sY: CGFloat = 1.1, ratio: CGFloat = 0.5) {
        let propertyAnimator = UIViewPropertyAnimator(duration: timeInterval, dampingRatio: ratio) {
            self.transform = CGAffineTransform.identity.scaledBy(x: sX, y: sY)
        }
        propertyAnimator.addAnimations({ self.transform = .identity }, delayFactor: CGFloat(timeInterval))
        propertyAnimator.startAnimation()
    }
    
    /// Add motion effect like in iphone background(move image with hiroscope)
    func addMotionEffect(value: CGFloat = 4) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            let horizontalMotionEffect = UIInterpolatingMotionEffect(keyPath: "center.x", type: .tiltAlongHorizontalAxis)
            horizontalMotionEffect.minimumRelativeValue = -value
            horizontalMotionEffect.maximumRelativeValue = value
            let verticalMotionEffect = UIInterpolatingMotionEffect(keyPath: "center.y", type: .tiltAlongVerticalAxis)
            verticalMotionEffect.minimumRelativeValue = -value
            verticalMotionEffect.maximumRelativeValue = value
            let motionEffectGroup = UIMotionEffectGroup()
            motionEffectGroup.motionEffects = [horizontalMotionEffect, verticalMotionEffect]
            self.addMotionEffect(motionEffectGroup)
        }
    }
    
    func viewCorner(_ radius: CGFloat? = nil) {
        layer.cornerRadius = radius ?? self.frame.height / 2
        layer.masksToBounds = true
    }
    
    func viewBorder(color: UIColor = .white, width: CGFloat = 1) {
        layer.borderColor = color.cgColor
        layer.borderWidth = width
    }
    
    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
    
    func roundCorners(_ corners: CACornerMask, radius: CGFloat) {
        self.layer.masksToBounds = true
        self.layer.cornerRadius = radius
        self.layer.maskedCorners = corners
    }
    
    class var identifier: String {
        return String(describing: self)
    }
    
    class func fromNib<T: UIView>() -> T {
        return Bundle.main.loadNibNamed(String(describing: T.self),
                                        owner: nil,
                                        options: nil)![0] as! T
    }
    
    func constrainToEdges(_ subview: UIView, top: CGFloat = 0, bottom: CGFloat = 0, leading: CGFloat = 0, trailing: CGFloat = 0) {
        subview.translatesAutoresizingMaskIntoConstraints = false
        
        let topContraint = NSLayoutConstraint(
            item: subview,
            attribute: .top,
            relatedBy: .equal,
            toItem: self,
            attribute: .top,
            multiplier: 1.0,
            constant: top)
        
        let bottomConstraint = NSLayoutConstraint(
            item: subview,
            attribute: .bottom,
            relatedBy: .equal,
            toItem: self,
            attribute: .bottom,
            multiplier: 1.0,
            constant: bottom)
        
        let leadingContraint = NSLayoutConstraint(
            item: subview,
            attribute: .leading,
            relatedBy: .equal,
            toItem: self,
            attribute: .leading,
            multiplier: 1.0,
            constant: leading)
        
        let trailingContraint = NSLayoutConstraint(
            item: subview,
            attribute: .trailing,
            relatedBy: .equal,
            toItem: self,
            attribute: .trailing,
            multiplier: 1.0,
            constant: trailing)
        
        addConstraints([
            topContraint,
            bottomConstraint,
            leadingContraint,
            trailingContraint])
    }
}

extension UIView {
    var heightConstraint: NSLayoutConstraint? {
        return constraints.first(where: {
            $0.firstAttribute == .height && $0.relation == .equal
        })
    }
    
    var widthConstraint: NSLayoutConstraint? {
        return constraints.first(where: {
            $0.firstAttribute == .width && $0.relation == .equal
        })
    }
}
