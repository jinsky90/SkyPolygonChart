//
//  PolygonChartDraw.swift
//  SkyPolygonChart
//
//  Created by 진하늘 on 23/09/2019.
//  Copyright © 2019 Jinsky. All rights reserved.
//

import UIKit

struct PolygonChartDraw {
    var radius: CGFloat?
    
    var fillColor       : CGColor       = UIColor.clear.cgColor
    var strokeColor     : CGColor       = UIColor.clear.cgColor
    
    var lineDashPattern : [NSNumber]?
    var lineWidth       : CGFloat       = 0
    
    var objectTextSet   : [String]?
    var objectColor     : UIColor       = UIColor.black
    var objectFont      : UIFont        = UIFont.systemFont(ofSize: 15, weight: .medium)
    
    var unitText        : String?
    var unitColor       : UIColor       = UIColor.black
    var unitFont        : UIFont        = UIFont.systemFont(ofSize: 12, weight: .regular)
    
    var isSkeleton      : Bool          = false
}
