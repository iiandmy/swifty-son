//
//  Serializer.swift
//  SwiftyJSON
//
//  Created by IlyaCool on 1.06.22.
//

import UIKit

enum DecodeError: Error {
    case invalidJson
}

enum Result {
    case success([Serializable])
    case empty
    case error
}

protocol Serializer {
    func serialize(_ objects: [Serializable]) -> String
    func deserialize(_ json: String) throws -> Result
}

class JsonTransportSerializer: Serializer {
    private let symbolsToRemove = [" ", "\n", "[", "]", "\""]
    private let symbolsToSkip = ["{", "}", ","]
    private let allowedSymbols = ["-", "."]
    
    private var jsonString: String!
    private var token: (tokType: String, val: String)!
    
    private let typeKeyWord = "type"
    private let bodyKeyWord = "body"
    
    private var endOfString: Bool = false
    private var currentIndex: String.Index! {
        didSet {
            if (currentIndex >= jsonString.endIndex) {
                endOfString = true
            }
        }
    }
    
    private func getNextObject() throws -> Transport? {
        nextToken()
        if (endOfString) {
            return .none
        }
        let type = token.val
        nextToken()
        let name = token.val
        nextToken()
        let speed = token.val
        nextToken()
        let weight = token.val
        do {
            return try TransportFactory.instance.getTransport(ofType: type, withName: name, speed: Int(speed) ?? 0, weight: Double(weight) ?? 0.0)
        } catch {
            throw DecodeError.invalidJson
        }
    }
    
    private func nextToken() {
        if (endOfString) {
            return
        }
        let currenSymb = jsonString[currentIndex]
        if (symbolsToSkip.contains(String(currenSymb))) {
            increaseIndex(for: 1)
            nextToken()
            return
        }
        else if (currenSymb.isLetter) {
            var id = parseWord()
            let value: String
            increaseIndex(for: 1)
            if (id == typeKeyWord) {
                value = parseWord()
                increaseIndex(for: 1)
            } else if (id == bodyKeyWord) {
                increaseIndex(for: 1)
                id = parseWord()
                increaseIndex(for: 1)
                value = parseWord()
            } else {
                value = parseWord()
                increaseIndex(for: 1)
            }
            token = (id, value)
        }
    }
    
    private func parseWord() -> String {
        var result = String(jsonString[currentIndex])
        increaseIndex(for: 1)
        let symb = jsonString[currentIndex]
        if (symb.isLetter || symb.isNumber ||
            allowedSymbols.contains(String(symb))) {
            
            result += parseWord()
        }
        return result
    }
    
    private func increaseIndex(for val: Int) {
        currentIndex = jsonString.index(currentIndex, offsetBy: val)
    }
    
    private func removeSymbols() {
        symbolsToRemove.forEach { symbol in
            self.jsonString = self.jsonString.replacingOccurrences(of: symbol, with: "")
        }
    }
    
    
    func serialize(_ objects: [Serializable]) -> String {
        var result = "[\n"
        objects.forEach { object in
            result += "\(object.serialize()),\n"
        }
        if let index = result.lastIndex(of: ",") {
            result.remove(at: index)
        }
        result += "]"
        return result
    }
    
    func deserialize(_ json: String) -> Result {
        jsonString = json
        removeSymbols()
        currentIndex = jsonString.startIndex
        var result = [Serializable]()
        
        while (true) {
            do {
                guard let transport = try getNextObject() else { break }
                result.append(transport)
            } catch {
                return .error
            }
        }
        return result.count != 0 ? .success(result) : .empty
    }
    
    
}
