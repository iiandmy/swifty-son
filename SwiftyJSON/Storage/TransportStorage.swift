//
//  TransportStorage.swift
//  SwiftyJSON
//
//  Created by IlyaCool on 21.05.22.
//

import UIKit

class TransportStorage {
    var transport = [Transport]()
    
    static let instance = TransportStorage()
    
    private init() {}
}
