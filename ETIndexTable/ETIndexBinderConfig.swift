//
//  ETIndexBinderConfig.swift
//  ETIndexTable
//
//  Created by Elijah on 2021/7/1.
//

import Foundation

public enum PagingBehaver {
    case none
    case withCellTop
    case whthCellMedium
}

public struct ETIndexBinderConfig {
    public var pagingBehaver: PagingBehaver = .none
    public init() {
        
    }
}
