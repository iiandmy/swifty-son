//
//  AddEntityController.swift
//  SwiftyJSON
//
//  Created by IlyaCool on 21.05.22.
//

import UIKit

class AddEntityController: UIViewController {

    @IBOutlet weak var picker: UIPickerView!
    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var speedTF: UITextField!
    @IBOutlet weak var weightTF: UITextField!
    
    weak var delegate: ViewEntitiesDelegateProtocol?
    
    private lazy var choosenType: String? = pickerContent[0]
    private let pickerContent = TransportFactory.instance.getKeys()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupPicker()
    }
    
    @IBAction func doneButtonPressed(_ sender: Any) {
        do {
            guard let type = choosenType,
                  let name = nameTF.text,
                  let speed = Int(speedTF.text ?? "50"),
                  let weight = Double(weightTF.text ?? "1000") else { return }
            
            let resultTransport = try TransportFactory.instance.getTransport(ofType: type, withName: name, speed: speed, weight: weight)
            
            delegate?.add(transport: resultTransport)
        } catch {
            fatalError()
        }
        self.navigationController?.popToRootViewController(animated: true)
    }
    
}

extension AddEntityController: UIPickerViewDataSource, UIPickerViewDelegate {
    func setupPicker() {
        picker.dataSource = self
        picker.delegate = self
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        pickerContent.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerContent[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        choosenType = pickerContent[row]
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
}
