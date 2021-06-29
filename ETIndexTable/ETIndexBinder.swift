//
//  ETIndexBinder.swift
//  ETIndexTable
//
//  Created by Elijah on 2021/6/30.
//

import UIKit


open class ETIndexBinder {
    private let indexTableViewController: ETIndexTableViewController
    private let dataTableViewController: ETDataTableViewController
    public init(indexTableViewController: ETIndexTableViewController,
         dataTableViewController: ETDataTableViewController) {
        self.indexTableViewController = indexTableViewController
        self.dataTableViewController = dataTableViewController
        self.indexTableViewController.etDelegate = self
        self.dataTableViewController.etDelegate = self
    }
}

extension ETIndexBinder: ETDataTableViewControllerDelegate {
    func selectRow(at indexPath: IndexPath) {
        indexTableViewController.tableView.selectRow(at: [indexPath.section,  0], animated: true, scrollPosition: .top)
    }
    
    func autoScrollCompleted() {
        dataTableViewController.restartUpdateIndex()
    }
    
    func didEndScrollingAnimation() {
        dataTableViewController.restartUpdateIndex()
    }
}

extension ETIndexBinder: ETIndexTableViewControllerDelegate {
    func didSelectRowAt(indexPath: IndexPath) {
        dataTableViewController.stopUpdateIndex()
        dataTableViewController.tableView.scrollToRow(at: [indexPath.section, 0], at: .top, animated: true)
    }
}
