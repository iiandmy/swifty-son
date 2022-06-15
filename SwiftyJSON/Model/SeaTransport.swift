//
//  SeaTransport.swift
//  SwiftyJSON
//
//  Created by IlyaCool on 21.05.22.
//

import UIKit

class SeaTransport: Transport {
    init(name: String, maxSpeed: Int, weight: Float) {
        super.init(transportType: "SeaTransport", name: name, maxSpeed: maxSpeed, weight: weight)
    }
}
