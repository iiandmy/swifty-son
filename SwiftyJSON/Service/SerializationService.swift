//
//  SerializationService.swift
//  SwiftyJSON
//
//  Created by IlyaCool on 21.05.22.
//

import UIKit

class SerializationService {
    private init() {}
    
    static func serialize(objects: [Serializable]) -> String {
        let serializer = JsonTransportSerializer()
        let result = serializer.serialize(objects)
        
        return result
    }
    
    static func deserialize(jsonString json: String) -> Result {
        let serializer = JsonTransportSerializer()
        
        return serializer.deserialize(json)
    }
}
