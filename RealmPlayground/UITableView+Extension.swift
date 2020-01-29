//
//  UITableView+Extension.swift
//  RealmPlayground
//
//  Created by Raphael-Alexander Berendes on 29.01.20.
//  Copyright © 2020 Raphael-Alexander Berendes. All rights reserved.
//

import UIKit

import RealmSwift

extension UITableView {

    func applyChanges<T>(changes: RealmCollectionChange<T>) {

        switch changes {
        case .initial: reloadData()
        case .update(_, let deletions, let insertions, let updates):
            let fromRow = {(row: Int) in
                return IndexPath(row: row, section: 0)}

            beginUpdates()
            deleteRows(at: deletions.map(fromRow), with: .automatic)
            insertRows(at: insertions.map(fromRow), with: .automatic)
            reloadRows(at: updates.map(fromRow), with: .none)
            endUpdates()
        default: break
        }
    }

}
