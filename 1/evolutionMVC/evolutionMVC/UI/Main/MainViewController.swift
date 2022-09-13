//
//  MainViewController.swift
//  evolutionMVC
//
//  Created by Vajda Kristóf on 2022. 09. 08..
//

import UIKit

class MainViewController: UIViewController {
    
    private var trailService: TrailService {
        return TrailServiceImpl(networkService: NetworkServiceImpl())
    }
    
    @IBOutlet private weak var tableView: UITableView!
    
    private var items: [NetworkModel.Trail] = [] {
        didSet {
            DispatchQueue.main.async { [weak self] in
                self?.tableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Trails"
        tableView.dataSource = self
        trailService.getTrails { [unowned self] result in
            switch result {
            case .success(let success):
                print(success)
                self.items = success
            case .failure(let failure):
                print(failure)
            }
        }
    }
}

extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "trailCell", for: indexPath) as? TrailCell else {
            return .init()
        }
        cell.nameLabel.text = items[indexPath.row].name

        return cell
    }
}
