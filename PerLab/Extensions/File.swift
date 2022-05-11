//
//  ViewController.swift
//  PerLab
//
//  Created by Lanqing Liu on 05/05/2022.
//  Copyright © 2022 Lanqing Liu. All rights reserved.

import Foundation


extension Array {
    func randomItem() -> Element? {
        if isEmpty { return nil }
        let index = Int(arc4random_uniform(UInt32(self.count)))
        return self[index]
    }
}
