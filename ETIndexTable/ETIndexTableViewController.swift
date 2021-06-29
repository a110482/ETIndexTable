//
//  ETIndexTableViewController.swift
//  ETIndexTable
//
//  Created by Elijah on 2021/6/30.
//

import UIKit

protocol ETIndexTableViewControllerDelegate: AnyObject {
    func didSelectRowAt(indexPath: IndexPath)
}

open class ETIndexTableViewController: UITableViewController {
    weak var etDelegate: ETIndexTableViewControllerDelegate?
    
    open override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        etDelegate?.didSelectRowAt(indexPath: indexPath)
    }
}
