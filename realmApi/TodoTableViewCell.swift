//
//  TodoTableViewCell.swift
//  realmApi
//
//  Created by karma on 3/14/22.
//

import UIKit

class TodoTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLbl: UILabel!
    
    func setData(task: Todos){
        nameLbl.text = task.title
    }

}
