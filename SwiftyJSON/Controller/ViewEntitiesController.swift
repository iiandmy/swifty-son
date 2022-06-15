//
//  ViewController.swift
//  SwiftyJSON
//
//  Created by IlyaCool on 20.05.22.
//

import UIKit

protocol ViewEntitiesDelegateProtocol: AnyObject {
    func add(transport: Transport)
}

class ViewEntitiesController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    private let storage = TransportStorage.instance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTable()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }

    func setupTable() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    @IBAction func clearButtonPressed() {
        storage.transport.removeAll()
        tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destinationVC = segue.destination as? AddEntityController else { return }
        destinationVC.delegate = self
    }
}

extension ViewEntitiesController: ViewEntitiesDelegateProtocol {
    func add(transport: Transport) {
        storage.transport.append(transport)
        tableView.reloadData()
    }
}

extension ViewEntitiesController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        storage.transport.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let transport = storage.transport[indexPath.row]
        
        cell.textLabel?.text = "\(transport.name): speed \(transport.maxSpeed), weight: \(Int(transport.weight))"
        
        return cell
    }
}
