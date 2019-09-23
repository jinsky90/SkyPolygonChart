//
//  PolygonChartData.swift
//  SkyPolygonChart
//
//  Created by 진하늘 on 23/09/2019.
//  Copyright © 2019 Jinsky. All rights reserved.
//

import UIKit

struct PolygonChartData {
    var fillColor       : CGColor       = UIColor.clear.cgColor
    var strokeColor     : CGColor       = UIColor.clear.cgColor
    
    var lineDashPattern : [NSNumber]?
    var lineWidth       : CGFloat       = 0
    var isAnimate       : Bool          = false
    var values          : [Double]?
}
