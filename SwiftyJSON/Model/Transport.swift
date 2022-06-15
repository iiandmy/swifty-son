//
//  Transport.swift
//  SwiftyJSON
//
//  Created by IlyaCool on 21.05.22.
//

import UIKit

protocol Serializable {
    var transportType: String { get }
    func serialize() -> String
}

class Transport: NSObject, Serializable {
    var transportType: String
    
    var name: String
    var maxSpeed: Int
    var weight: Double
    
    fileprivate init(transportType: String, name: String, maxSpeed: Int, weight: Double) {
        self.transportType = transportType
        self.name = name
        self.maxSpeed = maxSpeed
        self.weight = weight
    }

    func serialize() -> String {
        return """
        {
            "type": "\(transportType)",
            "body": {
                "name": "\(name)",
                "maxSpeed": \(maxSpeed),
                "weight": \(weight)
            }
        }
        """
    }

}

class SeaTransport: Transport {
    init(name: String, maxSpeed: Int, weight: Double) {
        super.init(transportType: "Sea Transport", name: name, maxSpeed: maxSpeed, weight: weight)
    }
}

class RoadTransport: Transport {
    init(name: String, maxSpeed: Int, weight: Double) {
        super.init(transportType: "Road Transport", name: name, maxSpeed: maxSpeed, weight: weight)
    }
}

class AirTransport: Transport {
    init(name: String, maxSpeed: Int, weight: Double) {
        super.init(transportType: "Air Transport", name: name, maxSpeed: maxSpeed, weight: weight)
    }
}

class HorseDrawnTransport: Transport {
    init(name: String, maxSpeed: Int, weight: Double) {
        super.init(transportType: "Horse Drawn Transport", name: name, maxSpeed: maxSpeed, weight: weight)
    }
}

class NonMechanicalTransport: Transport {
    init(name: String, maxSpeed: Int, weight: Double) {
        super.init(transportType: "Non-Mechanical Transport", name: name, maxSpeed: maxSpeed, weight: weight)
    }
}
