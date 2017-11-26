//
//  ActionSheetItem.swift
//  Sheeeeeeeeet
//
//  Created by Daniel Saidi on 2017-11-24.
//  Copyright © 2017 Daniel Saidi. All rights reserved.
//

/*
 
 This class represents a regular action sheet item, like the
 ones used by UIAlertController. It has an optional value to
 help identify what the user taps, as well as a title and an
 optional image.
 
 The default tap behavior of an action sheet item is to tell
 the action sheet that it was tapped, then dismiss the sheet.
 If you don't want the action sheet to be dismissed, you can
 set the `tapBehavo`
 the actoin hide
 the action sheet whenever it is tapped. This is changed by setting
 
 */

import UIKit

open class ActionSheetItem: NSObject {
    
    
    // MARK: - Initialization
    
    public init(value: Any, title: String, image: UIImage? = nil) {
        self.value = value
        self.title = title
        self.image = image
        super.init()
    }
    
    
    // MARK: - Properties
    
    open lazy var appearance: ActionSheetItemAppearance = {
        return ActionSheetItemAppearance(copy: ActionSheetAppearance.standard.item)
    }()
    
    open var value: Any
    open var image: UIImage?
    open var tapBehavior: ActionSheetItemTapBehavior = .dismiss
    open var title: String
    
    open var height: Int {
        return appearance.height
    }
    
    
    // MARK: - Internal Properties
    
    var dismissesOnTap: Bool {
        switch tapBehavior {
        case .dismiss: return true
        default: return false
        }
    }
    
    
    // MARK: - Functions
    
    open func applyAppearance(to cell: UITableViewCell) {
        cell.separatorInset = appearance.separatorInsets
        cell.tintColor = appearance.tintColor
        cell.textLabel?.textColor = appearance.textColor
        cell.textLabel?.font = appearance.font
    }
    
    open func cell(for tableView: UITableView) -> UITableViewCell {
        let id = type(of: self).className
        let cell = tableView.dequeueReusableCell(withIdentifier: id) as? ActionSheetItemCell
            ?? ActionSheetItemCell(style: .default, reuseIdentifier: id)
        cell.imageView?.image = image
        cell.textLabel?.text = title
        applyAppearance(to: cell)
        return cell
    }
}
