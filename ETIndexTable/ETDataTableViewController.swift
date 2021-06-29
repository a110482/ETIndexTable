//
//  IndexTableViewAble.swift
//  TableIndexPlugin
//
//  Created by Elijah on 2021/6/24.
//

import UIKit


protocol ETDataTableViewControllerDelegate: AnyObject {
    func selectRow(at indexPath: IndexPath )
    func autoScrollCompleted()
    func didEndScrollingAnimation()
}

open class ETDataTableViewController: UITableViewController {
    weak var etDelegate: ETDataTableViewControllerDelegate?
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue.main.async {
            self.updateIndex()
        }
    }
    
    open override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return super.tableView(tableView, numberOfRowsInSection: section)
    }
    
    open override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        updateIndex()
    }
    
    open override func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        etDelegate?.didEndScrollingAnimation()
    }
    
    func updateIndex() {
        guard needUpdateIndex else { return }
        let cells = tableView.visibleCells
        guard let firstCell = cells.min(by: { $0.center.y < $1.center.y }) else { return }
        guard let indexPath = tableView.indexPath(for: firstCell) else { return }
        etDelegate?.selectRow(at: indexPath)
    }
    
    func stopUpdateIndex() {
        needUpdateIndex = false
    }
    
    func restartUpdateIndex() {
        needUpdateIndex = true
    }
    
    private var needUpdateIndex = true
}


