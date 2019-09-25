//
//  PolygonChartView.swift
//  SkyPolygonChart
//
//  Created by 진하늘 on 23/09/2019.
//  Copyright © 2019 Jinsky. All rights reserved.
//

import UIKit

protocol PolygonChartViewDelegate: class {
    func setPolygonChartDataSets(polygonChart: PolygonChartView) -> PolygonChartDataSet?
    func setPolygonChartDrawSets(polygonChart: PolygonChartView, radius: CGFloat) -> PolygonChartDrawSet
    func numberOfPolygonChart(polygonChart: PolygonChartView) -> Int 
}

class PolygonChartView: UIView {
    private var radius      : CGFloat { return self.bounds.size.width > self.bounds.size.height ? self.bounds.size.height / 3 : self.bounds.size.width / 3 }
    private var xCenter     : CGFloat { return self.bounds.midX }
    private var yCenter     : CGFloat { return self.bounds.midY }
    private var step        : CGFloat { return CGFloat(2 * Double.pi / Double(side)) }
    
    private var side        : Int = 0
    
    private var dataSet     : PolygonChartDataSet? {
        didSet {
            self.dataSet?.dataSet?.forEach { self.drawData($0) }
        }}
    
    weak var delegate: PolygonChartViewDelegate?
    
    func start() {
        self.initIndex()
        self.initDraw()
        self.initData()
    }
    
    private func initIndex() {
        guard let index = self.delegate?.numberOfPolygonChart(polygonChart: self) else { return }
        self.side = index
    }
    
    private func initData() {
        guard let dataSet = self.delegate?.setPolygonChartDataSets(polygonChart: self) else { return }
        self.dataSet = dataSet
    }

    private func initDraw() {
        guard let drawSet = self.delegate?.setPolygonChartDrawSets(polygonChart: self, radius: self.radius) else { return }
        drawSet.drawSet?.forEach { self.drawBorderShape($0) }
        drawSet.drawSet?.forEach { self.drawText($0) }
    }
    
    private func drawBorderShape(_ draw: PolygonChartDraw) {
        guard let radius = draw.radius else { return }
        
        let shapeLayer = CAShapeLayer()
        let path = UIBezierPath()
        
        shapeLayer.fillColor = draw.fillColor
        shapeLayer.lineDashPattern = draw.lineDashPattern
        shapeLayer.lineWidth = draw.lineWidth
        shapeLayer.strokeColor = draw.strokeColor
        
        if !draw.isSkeleton { path.move(to: CGPoint(x: xCenter, y: yCenter - radius)) }
        
        for index in 1...side {
            if draw.isSkeleton {
                path.move(to: CGPoint(x: xCenter, y: yCenter))
                if index == 1 {
                    path.addLine(to: CGPoint(x: xCenter, y: yCenter - radius))
                } else {
                    path.addLine(to: CGPoint(x: xCenter + radius * sin(CGFloat(index - 1) * step), y: yCenter - radius * cos(CGFloat(index - 1) * step)))
                }
                path.addLine(to: CGPoint(x: xCenter + radius * sin(CGFloat(index) * step), y: yCenter - radius * cos(CGFloat(index) * step)))
            } else {
                path.addLine(to: CGPoint(x: xCenter + radius * sin(CGFloat(index - 1) * step), y: yCenter - radius * cos(CGFloat(index - 1) * step)))
            }
        }

        path.close()

        shapeLayer.path = path.cgPath
        
        self.layer.addSublayer(shapeLayer)
    }
    
    private func drawData(_ data: PolygonChartData) {
        guard var tempValues = data.values else { return }

        let dataView = UIView()
        let shapeLayer = CAShapeLayer()
        let path = UIBezierPath()

        shapeLayer.fillColor = data.fillColor
        shapeLayer.lineDashPattern = data.lineDashPattern
        shapeLayer.lineWidth = data.lineWidth
        shapeLayer.strokeColor = data.strokeColor

        path.move(to: CGPoint(x: xCenter, y: yCenter - (radius * CGFloat((tempValues.first ?? 0) * 0.01))))

        let removedfirstData = tempValues.removeFirst()
        tempValues.append(removedfirstData)

        tempValues.enumerated().forEach { (index, value) in
            let newRadius = radius * CGFloat(value * 0.01)
            path.addLine(to: CGPoint(x: xCenter + newRadius * sin(CGFloat(index + 1) * step), y: yCenter - newRadius * cos(CGFloat(index + 1) * step)))
        }

        path.close()

        shapeLayer.path = path.cgPath
        dataView.layer.addSublayer(shapeLayer)
        self.addSubview(dataView)

        guard data.isAnimate else { return }

        dataView.translatesAutoresizingMaskIntoConstraints = false
        dataView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        dataView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        dataView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        dataView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        
        dataView.layer.setAffineTransform(CGAffineTransform(scaleX: 0, y: 0))

        UIView.animate(withDuration: 1.0, delay: 0, options: UIView.AnimationOptions.curveEaseInOut, animations: {
            dataView.layer.setAffineTransform(CGAffineTransform(scaleX: 1, y: 1))
        }, completion: nil)
    }
    
    private func drawText(_ draw: PolygonChartDraw) {
        guard let radius = draw.radius else { return }
        if let unitText = draw.unitText { self.drawLabel(center: CGPoint(x: xCenter, y: yCenter - radius), text: unitText, font: draw.unitFont, color: draw.unitColor) }
        guard let objectText = draw.objectTextSet else { return }
        
        for index in 1...side {
            if let text = objectText[safe: index - 1] {
                guard text != "" else { continue }
                self.drawLabel(center: CGPoint(x: xCenter + (radius * 1.2) * sin(CGFloat(index - 1) * step),
                                               y: yCenter - (radius * 1.2) * cos(CGFloat(index - 1) * step)),
                               text: text,
                               font: draw.objectFont,
                               color: draw.objectColor)
            }
        }
    }
    
    private func drawLabel(center: CGPoint, text: String, font: UIFont = UIFont.systemFont(ofSize: 12), color: UIColor = .black) {
        let label = UILabel()
        self.addSubview(label)
        label.font = font
        label.textColor = color
        label.text = text
        label.sizeToFit()
        label.center = center
        label.textAlignment = .center
    }
    
}
