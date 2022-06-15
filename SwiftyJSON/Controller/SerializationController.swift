//
//  SerializationController.swift
//  SwiftyJSON
//
//  Created by IlyaCool on 21.05.22.
//

import UIKit

class SerializationController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func serializeButtonPressed(_ sender: Any) {
        let serializationResult = SerializationService.serialize(objects: TransportStorage.instance.transport)
        FileService.instance.writeInFile(jsonString: serializationResult)
    }
    
    @IBAction func deserializeButtonPressed(_ sender: Any) {
        guard let readedJson = FileService.instance.readFromFile() else { return }
        let result = SerializationService.deserialize(jsonString: readedJson)
        
        switch result {
        case .error:
            showAllert(message: "Error!", description: "Something went wrong.")
        case .empty:
            showAllert(message: "Warning!", description: "Json file you trying to parse is empty")
        case .success(let result):
            result.forEach { transport in
                TransportStorage.instance.transport.append(transport as! Transport)
            }
        }
    }
    
    @IBAction func clearFilePressed(_ sender: Any) {
        FileService.instance.clearFile()
    }
    
    func showAllert(message: String, description: String) {
        let alert = UIAlertController(title: message, message: description, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
}
