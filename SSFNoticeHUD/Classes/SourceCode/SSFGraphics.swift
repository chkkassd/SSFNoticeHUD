//
//  SSFProgressDrawImage.swift
//  SSFProgressHUD
//
//  Created by PeterShi_CooTek on 2019/7/23.
//  Copyright © 2019 PeterShi_CooTek. All rights reserved.
//Read me：
//使用UIKit对CoreGraphics封装的高级接口，绘制简单图形，目前有：✅，❌，消息，共三种图像，并以Uiimage形式返回

import Foundation
import UIKit

public struct SSFGraphics: GraphicsCheckMarkProtocol, GraphicsCrossProtocol, GraphicsInfoProtocol {
    
    public enum graphicType {
        case checkMark
        case cross
        case info
    }
    
    public static func getImage(type: graphicType) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(CGSize(width: 36, height: 36), false, 0)
        let graphic = SSFGraphics()
        switch type {
        case .checkMark:
            graphic.drawCheckMark()
        case .cross:
            graphic.drawCross()
        case .info:
            graphic.drawInfo()
        }
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
}

// MARK: Draw checkmark
protocol GraphicsCheckMarkProtocol {
    func drawCheckMark()
}

extension GraphicsCheckMarkProtocol {
    func drawCheckMark() {
        let path = UIBezierPath()
        
        // draw circle
        path.move(to: CGPoint(x: 36, y: 18))
        path.addArc(withCenter: CGPoint(x: 18, y: 18), radius: 17.5, startAngle: 0, endAngle: CGFloat(Double.pi*2), clockwise: true)
        path.close()
        //draw checkmark
        path.move(to: CGPoint(x: 10, y: 18))
        path.addLine(to: CGPoint(x: 16, y: 24))
        path.addLine(to: CGPoint(x: 27, y: 13))
        path.move(to: CGPoint(x: 10, y: 18))
        path.close()
        //color
        UIColor.white.setStroke()
        path.stroke()
    }
}

// MARK: Draw cross
protocol GraphicsCrossProtocol {
    func drawCross()
}

extension GraphicsCrossProtocol {
    func drawCross() {
        let path = UIBezierPath()
        
        // draw circle
        path.move(to: CGPoint(x: 36, y: 18))
        path.addArc(withCenter: CGPoint(x: 18, y: 18), radius: 17.5, startAngle: 0, endAngle: CGFloat(Double.pi*2), clockwise: true)
        path.close()
        //draw cross
        path.move(to: CGPoint(x: 10, y: 10))
        path.addLine(to: CGPoint(x: 26, y: 26))
        path.move(to: CGPoint(x: 10, y: 26))
        path.addLine(to: CGPoint(x: 26, y: 10))
        path.move(to: CGPoint(x: 10, y: 10))
        path.close()
        //color
        UIColor.white.setStroke()
        path.stroke()
    }
}

// MARK: Draw info
protocol GraphicsInfoProtocol {
    func drawInfo()
}

extension GraphicsCheckMarkProtocol {
    func drawInfo() {
        let path = UIBezierPath()
        
        // draw circle
        path.move(to: CGPoint(x: 36, y: 18))
        path.addArc(withCenter: CGPoint(x: 18, y: 18), radius: 17.5, startAngle: 0, endAngle: CGFloat(Double.pi*2), clockwise: true)
        path.close()
        //draw info
        path.move(to: CGPoint(x: 18, y: 6))
        path.addLine(to: CGPoint(x: 18, y: 22))
        path.move(to: CGPoint(x: 18, y: 6))
        path.close()
        
        UIColor.white.setStroke()
        path.stroke()
        
        let circlePointPath = UIBezierPath()
        circlePointPath.move(to: CGPoint(x: 18, y: 27))
        circlePointPath.addArc(withCenter: CGPoint(x: 18, y: 27), radius: 1, startAngle: 0, endAngle: CGFloat(Double.pi*2), clockwise: true)
        circlePointPath.close()
        
        UIColor.white.setFill()
        circlePointPath.fill()
        //color
        UIColor.white.setStroke()
        path.stroke()
    }
}
