//
//  ViewController.swift
//  Learning
//
//  Created by LivingMobile on 13/1/2563 BE.
//  Copyright © 2563 LivingMobile. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    private var dataList = [DataModel]()
    private let apiClient = ApiClient()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "TableViewCell")
        requestData()
    }
    
    //MARK: - request data
    private func requestData() {
        debugPrint("Fetching")
        apiClient.requestDataList (completion: { [weak self] (results, error) in
            guard let weakSelf = self else {
                return
            }
            guard let results = results else {
                debugPrint("Error : \(String(describing: error))")
                return
            }
            
            weakSelf.dataList = results
            
            weakSelf.tableView.reloadData()
            debugPrint("Finished Fetch")
        })
    }
    
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell") as! TableViewCell
        let data = dataList[indexPath.row]
        cell.data = data
        return cell
    }
}

