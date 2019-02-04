//
//  NewsTableViewController.swift
//  VK_Anna_Ershova
//
//  Created by Anna Ershova on 1/21/19.
//  Copyright © 2019 Anna Ershova. All rights reserved.
//

import UIKit

class NewsTableViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // delegate and data source
        tableView.delegate = self
        tableView.dataSource = self
        
         //Along with auto layout, these are the keys for enabling variable cell height
        //tableView.estimatedRowHeight = 44
        //tableView.rowHeight = UITableView.automaticDimension
    }
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 3
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "News", for: indexPath) as! NewsTableViewCell

        tableView.rowHeight = cell.textNews.frame.size.height + cell.imageNews.frame.size.height + cell.customStack.frame.size.height * 3

        return cell
    }
    
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    
//    func calculateHeightForConfiguredSizingCell(cell: NewsTableViewCell) -> CGFloat {
//        cell.setNeedsLayout()
//        cell.layoutIfNeeded()
//        let height = cell.contentView.systemLayoutSizeFitting(UIView.layoutFittingExpandedSize).height + 1.0
//        return height
//    }
    
}
