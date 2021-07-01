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
    // open
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
    
    open override func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if !decelerate {
            pagingAnimate()
        }
    }
    
    open override func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        pagingAnimate()
    }
    
    // internal
    weak var etDelegate: ETDataTableViewControllerDelegate?
    
    var pagingBehaver: PagingBehaver = .none
    
    func stopUpdateIndex() {
        needUpdateIndex = false
    }
    
    func restartUpdateIndex() {
        needUpdateIndex = true
    }
    
    // private
    private var needUpdateIndex = true
    
    private func updateIndex() {
        guard needUpdateIndex else { return }
        let cells = tableView.visibleCells
        guard let firstCell = cells.min(by: { $0.center.y < $1.center.y }) else { return }
        guard let indexPath = tableView.indexPath(for: firstCell) else { return }
        etDelegate?.selectRow(at: indexPath)
    }
}

// Paging
extension ETDataTableViewController {
    private func pagingAnimate() {
        guard pagingBehaver != .none else { return }
        let cells = tableView.visibleCells
        if cells.count == 0 {
            scrollToLastCell()
        } else if cells.count == 1 {
            scrollToFirstVisibleCell()
        } else {
            scrollToNearbyCell()
        }
        
        
    }
    
    private func scrollToFirstVisibleCell() {
        let cells = tableView.visibleCells
        guard cells.count > 0 else { return }
        guard let index = tableView.indexPath(for: cells[0]) else { return }
        tableView.scrollToRow(at: index, at: .top, animated: true)
    }
    
    private func scrollToLastCell() {
        let lastSection = numberOfSections(in: tableView) - 1
        let lastRow = tableView(tableView, numberOfRowsInSection: lastSection) - 1
        tableView.scrollToRow(at: [lastSection, lastRow], at: .top, animated: true)
    }
    
    private func scrollToNearbyCell() {
        let cells = tableView.visibleCells
        let offset = tableView.contentOffset.y
        let criticalValue: CGFloat
        switch pagingBehaver {
        case .none:
            criticalValue = 0
        case .withCellTop:
            criticalValue = cells[0].bounds.height
        case .withCellMedium:
            criticalValue = cells[0].bounds.height/2
        }
        
        let scrollTopCell = (offset - cells[0].frame.origin.y) < criticalValue ? cells[0] : cells[1]
        guard let index = tableView.indexPath(for: scrollTopCell) else { return }
        tableView.scrollToRow(at: index, at: .top, animated: true)
    }
}
