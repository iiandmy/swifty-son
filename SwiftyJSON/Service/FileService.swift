//
//  FileService.swift
//  SwiftyJSON
//
//  Created by IlyaCool on 21.05.22.
//

import UIKit

class FileService {
    static let instance = FileService()
    
    private let fileManager = FileManager()
    private let fileName = "test.txt"
    private lazy var tempDir = fileManager.temporaryDirectory
    private lazy var path = tempDir.appendingPathComponent(fileName)
    
    func readFromFile() -> String? {
        do {
            let result = try String(contentsOf: path, encoding: .utf8)
            
            return result
        } catch {
            print("Error reading from file")
            return nil
        }
    }
    
    func writeInFile(jsonString: String) {
        do {
            recreateFile(at: path)
            try jsonString.write(to: path, atomically: true, encoding: .utf8)
        } catch {
            print("Error writing in file")
        }
    }
    
    func clearFile() {
        recreateFile(at: path)
    }
    
    private func recreateFile(at path: URL) {
        do {
            if (fileManager.fileExists(atPath: path.path)) {
                try fileManager.removeItem(at: path)
            }
            fileManager.createFile(atPath: path.path, contents: nil, attributes: nil)
        } catch {
            print("Error creating file")
        }
    }
    
    private init() {}
}
