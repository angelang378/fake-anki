//
//  CanvasView.swift
//  gizou-hin
//
//  Created by Angela Ng on 8/8/20.
//  Copyright © 2020 Angela Ng. All rights reserved.
//

import UIKit

class CanvasView: UIView {
    
    var lines = [[CGPoint]]()

    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        guard let context = UIGraphicsGetCurrentContext() else {
            return
        }
        context.setStrokeColor(UIColor.black.cgColor)
        context.setLineWidth(5)
        context.setLineCap(.butt)
        lines.forEach { (line) in
            for (i,p) in line.enumerated() {
                if i == 0{
                    context.move(to: p)
                } else{
                    context.addLine(to: p)
                }
            }
            context.strokePath()
        }
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        lines.append([CGPoint]())
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let point = touches.first?.location(in: self) else{
            return
        }
        
        guard var lastLine = lines.popLast() else {return}
        lastLine.append(point)
        lines.append(lastLine)
        setNeedsDisplay()
    }
    
    func clearCanvas(){
        lines.removeAll()
        setNeedsDisplay()
    }

}
