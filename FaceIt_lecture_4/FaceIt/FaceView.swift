//
//  FaceView.swift
//  FaceIt
//
//  Created by Alonso Zhang on 16/6/29.
//  Copyright © 2016年 Alonso Zhang. All rights reserved.
//

import UIKit

class FaceView: UIView {
    var scale: CGFloat = 0.90
    var mouthCurvature : Double = 1.0 //1 full smile, -1 full frown
    var eyesOpen : Bool = true
    var eyeBrowTitle :Double = 0.0 //1 full furrow, -1 full relaxed
    
    private var skullRadius: CGFloat {
        return min(bounds.size.width, bounds.size.height) / 2
    }
    private var skullCenter: CGPoint {
        return CGPoint(x: bounds.midX, y: bounds.midY)
    }
    
    private struct Ratios {
        static let SkullRadiusToEyeOffset : CGFloat = 3
        static let SkullRadiusToEyeRadius : CGFloat = 10
        static let SkullRadiusToMouthWidth : CGFloat = 1
        static let SkullRadiusToMouthHeight : CGFloat = 3
        static let SkullRadiusToMouthOffset : CGFloat = 3
    }
    
    private enum Eye {
        case Left
        case Right
    }
    
    private func pathForCicleCenteredAtPoint(midPoint: CGPoint, withRadius radius: CGFloat) -> UIBezierPath {
        let path = UIBezierPath(
            arcCenter: midPoint,
            radius: radius,
            startAngle: 0,
            endAngle: CGFloat(2*M_PI),
            clockwise: true
        )
        path.lineWidth = 5.0
        return path
    }
    
    private func getEyeCenter(eye: Eye) -> CGPoint {
        let eyeOffset = skullRadius / Ratios.SkullRadiusToEyeOffset
        var eyeCenter = skullCenter
        eyeCenter.y -= eyeOffset
        switch eye {
        case .Left:
            eyeCenter.x -= eyeOffset
        case .Right:
            eyeCenter.x += eyeOffset
        }
        return eyeCenter
    }

    private func pathForMouth() -> UIBezierPath {
        let mouthWidth = skullRadius / Ratios.SkullRadiusToMouthWidth
        let mouthHeight = skullRadius / Ratios.SkullRadiusToMouthHeight
        let mouthOffset = skullRadius / Ratios.SkullRadiusToMouthOffset
        
        let mouthRect = CGRect(x:skullCenter.x - mouthWidth/2, y:skullCenter.y + mouthOffset ,width:mouthWidth,height: mouthHeight)
        
        let smileOffset = CGFloat(max(-1, min(mouthCurvature,1))) * mouthRect.height
        let start = CGPoint(x: mouthRect.minX, y: mouthRect.minY)
        let end = CGPoint(x:mouthRect.maxX, y:mouthRect.minY)
        let cp1 = CGPoint(x:mouthRect.minX + mouthRect.width/3, y:mouthRect.minY + smileOffset)
        let cp2 = CGPoint(x:mouthRect.maxX - mouthRect.width/3, y:mouthRect.minY + smileOffset)
        
        let path = UIBezierPath()
        path.moveToPoint(start)
        path.addCurveToPoint(end, controlPoint1: cp1, controlPoint2: cp2)
        
        path.lineWidth = 5.0
        return path
    }
    
    private func pathForEye(eye: Eye) -> UIBezierPath{
        let eyeRadius = skullRadius / Ratios.SkullRadiusToEyeRadius
        let eyeCenter = getEyeCenter(eye)
        if eyesOpen{
            return pathForCicleCenteredAtPoint(eyeCenter, withRadius: eyeRadius)
        }else{
            var tilt = eyeBrowTilt
            switch eye {
            case .Left: tilt *= -1.0
            case .Right: break
            }
            var browCenter = getEyeCenter(eye)
            browCenter.y -= skullRadius / Ratios.SkullRadiusToBrowOffset
            let eyeRadius = skullRadius / Ratios.SkullRadiusToEyeRadius
            let tiltOffset = CGFloat(max(-1, min(tilt, 1))) * eyeRadius / 2
            let browStart = CGPoint(x: browCenter.x - eyeRadius, y: browCenter.y - tiltOffset)
            let browEnd = CGPoint(x: browCenter.x + eyeRadius, y: browCenter.y + tiltOffset)
            let path = UIBezierPath()
            path.moveToPoint(browStart)
            path.addLineToPoint(browEnd)
            path.lineWidth = lineWidth
            return path
        }
        
    }
    
    override func drawRect(rect: CGRect) {
        pathForCicleCenteredAtPoint(skullCenter, withRadius: skullRadius).stroke()
        UIColor.blueColor().set()
        pathForEye(.Left).stroke()
        pathForEye(.Right).stroke()
        pathForMouth().stroke()
        pathforBrow().stroke()
    }
}