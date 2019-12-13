//
//  ViewController.swift
//  ExpandCell
//
//  Created by 박균호 on 13/12/2019.
//  Copyright © 2019 박균호. All rights reserved.
//

import UIKit

class ExpandCell: UITableViewCell{
    
    @IBOutlet weak var descriptionLabel: UILabel!
}

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    // Model
    struct ExpandDataModel {
        var description: String
        var isExpand: Bool
    }
    
    // .init()
    var dataModels = [ExpandDataModel]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let textArray = ["short text",
                         "long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long",
                         "long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long",
                         "long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long",
                         "long long long long long long long long long long long long long long long long long long long long long ",
                         "short text"]
        
        for (_, value) in textArray.enumerated(){
            dataModels.append(ExpandDataModel.init(description: value, isExpand: false))
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "expandCell_ID", for: indexPath) as! ExpandCell
        cell.descriptionLabel.text = dataModels[indexPath.row].description
        
        if dataModels[indexPath.row].isExpand {
            cell.descriptionLabel.numberOfLines = 0
            // 0 : text 수 만큼 전부 표현
            // 1: text 한줄
            // 2: text 두줄
        }else{
            cell.descriptionLabel.numberOfLines = 1
        }
        
        cell.selectionStyle = .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        dataModels[indexPath.row].isExpand = !dataModels[indexPath.row].isExpand
        
        // table row가 튀는 현상 발생할때,
        // 1. heightForRowAt 에서 정확한 높이를 지정 : 확실히 해결
        
        // 2. tableView.reloadData() : 어느정도 해결
        
        // 3-1. estimatedRowHeight = automaticDimension :
        // 3-2. estimatedSectionHeaderHeight = 0
        // 3-3. estimatedSectionFooterHeight = 0
        
        // 4. 애니메이션 효과 없애는 방법 : 확실히 해결
        // UIView.setanimationsEnabled(false) -> reload -> UIView.setanimationsEnabled(true)
        tableView.reloadRows(at: [indexPath], with: .none)

        
    }
}

