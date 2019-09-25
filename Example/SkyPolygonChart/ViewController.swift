//
//  ViewController.swift
//  SkyPolygonChart
//
//  Created by 진하늘 on 23/09/2019.
//  Copyright © 2019 Jinsky. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var polygonChartWrapView: PolygonChartView!
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.initPolygonChartView()
    }
    
    func initPolygonChartView() {
        self.polygonChartWrapView.delegate = self
        self.polygonChartWrapView.backgroundColor = .clear
        self.polygonChartWrapView.start()
    }
}

extension ViewController: PolygonChartViewDelegate {
    func setPolygonChartDrawSets(polygonChart: PolygonChartView, radius: CGFloat) -> PolygonChartDrawSet {
        
        // 100%
        var set1 = PolygonChartDraw()
        set1.radius = radius
        set1.lineWidth = 1
        set1.strokeColor = UIColor.gray.cgColor
        set1.objectTextSet = ["ATT", "TEC", "STA", "DEF", "POW", "SPD"]
        set1.unitText = "100"
        set1.unitColor = .gray
        set1.isSkeleton = true
        
        // 50%
        var set2 = PolygonChartDraw()
        set2.radius = radius / 2
        set2.lineWidth = 1
        set2.strokeColor = UIColor.gray.cgColor
        set2.unitText = "50"
        set2.unitColor = .gray
        
        return PolygonChartDrawSet(drawSet: [set1, set2])
    }
    
    func setPolygonChartDataSets(polygonChart: PolygonChartView) -> PolygonChartDataSet? {
        
        // Data Value1
        var set1 = PolygonChartData()
        set1.fillColor = UIColor.purple.withAlphaComponent(0.8).cgColor
        set1.values = [80,75,89,80,99,70]
        set1.lineWidth = 3
        set1.isAnimate = true
        
        // Data Value2(ex: Average)
        var set2 = PolygonChartData()
        set2.lineDashPattern = [3,3]
        set2.values = [80,80,80,80,80,80]
        set2.lineWidth = 1
        set2.strokeColor = UIColor.gray.cgColor
        
        return PolygonChartDataSet(dataSet: [set1, set2])
    }
    
    func numberOfPolygonChart(polygonChart: PolygonChartView) -> Int {
        return 6
    }
}
