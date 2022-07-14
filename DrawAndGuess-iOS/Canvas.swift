//
//  Canvas.swift
//  DAG
//
//  Created by Mac on 2022/7/14.
//

import Foundation
import UIKit
class Canvas: UIView {
    var lines = [Line]()
    var strokeColor = UIColor.black
    var lineWidth = 1
    func changeWidth(width: Int) {
        lineWidth = width
    }
    func changeColor(color: UIColor) {
        strokeColor=color
    }
    func undo(){
        _ = lines.popLast()
        setNeedsDisplay()
    }
    func clear(){
        lines.removeAll()
        setNeedsDisplay()
    }
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        guard let context = UIGraphicsGetCurrentContext() else
        { return }
        context.setLineCap(.butt)
        lines.forEach { (line) in
            context.setStrokeColor(line.color.cgColor)
            context.setLineWidth(CGFloat(line.width))
            for (i,p) in line.points.enumerated() {
                if i==0 {
                    context.move(to: p)
                } else {
                    context.addLine(to: p)
                }
            }
            context.strokePath()
        }
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        lines.append(Line(width: Float(lineWidth), color: strokeColor, points: [CGPoint]()))
    }
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let point = touches.first?.location(in: nil) else { return }
        guard var lastLine=lines.popLast() else { return }
        lastLine.points.append(point)
        lines.append(lastLine)
        setNeedsDisplay()
    }
}
