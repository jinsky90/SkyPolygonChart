//
//  Array+Extension.swift
//  SkyPolygonChart
//
//  Created by 진하늘 on 23/09/2019.
//  Copyright © 2019 Jinsky. All rights reserved.
//

import UIKit

extension Array {
    subscript (safe index: Int) -> Element? {
        return startIndex <= index && index < endIndex ? self[index] : nil
    }
}
