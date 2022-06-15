//
//  FileViewController.swift
//  SwiftyJSON
//
//  Created by IlyaCool on 21.05.22.
//

import UIKit

class FileViewController: UIViewController {

    @IBOutlet weak var textArea: UITextView!
    
    private let textForArea = FileService.instance.readFromFile()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textArea.text = textForArea
    }

}
