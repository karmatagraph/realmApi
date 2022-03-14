//
//  ViewController.swift
//  realmApi
//
//  Created by karma on 3/14/22.
//

import UIKit
import RealmSwift
import SwiftUI

class ViewController: UIViewController {

    let realm = try! Realm()
    @IBOutlet weak var tableView: UITableView!
    let url = URL(string: "https://jsonplaceholder.typicode.com/todos")
    var list: [Todos] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // location of the realm file
        print("Realm is located at:", realm.configuration.fileURL!)
        
        tableView.delegate = self
        tableView.dataSource = self
        getAllData()
//        getData()
//          deleteAllData()
        
        
    }
    
    func deleteAllData(){
        do{
            realm.beginWrite()
            realm.deleteAll()
            try realm.commitWrite()
//            getData()
            
        }catch let error{
            print("error saving data: \(error)")
        }
    }
    func getData(){
        guard let url = url else {
            return
        }
        let session = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            if let error = error {
                print("error geting data: \(error)")
            }else{
                do{
                    guard let data = data else {
                        return
                    }

                    // let res = try JSONSerialization.jsonObject(with: data, options: [])
                    let res = try JSONDecoder().decode([Todos].self, from: data)
                    self?.list = res
                    DispatchQueue.main.async {
                        self?.saveData(todos: res)
                    }
                    
                
//                    for resp in res{
//                        DispatchQueue.main.async {
//                            self?.saveData(todos: resp)
//                        }
//
//                    }
                    print(res)
                    print(self?.list as Any)
//                    DispatchQueue.main.async {
//                        self?.tableView.reloadData()
//                    }
                    
                }catch let error{
                    print("error loading data\(error.localizedDescription)")
                }
                
            }
            
        }
        session.resume()
    }
    
    func saveData(todos: [Todos]){
        
        do{
            realm.beginWrite()
            for todo in todos{
                realm.add(todo)
            }
            try realm.commitWrite()
        }catch let error{
            print("error saving data: \(error)")
        }
        
    }
    
    func getAllData(){
        // Get all tasks in the realm
        list = Array(realm.objects(Todos.self))
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
        
    }


}

extension ViewController: UITableViewDelegate{
    
}

extension ViewController: UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let task = list[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoTableViewCell", for: indexPath) as! TodoTableViewCell
        cell.setData(task: task)
        return cell
    }
}
