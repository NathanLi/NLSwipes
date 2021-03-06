//
//  NSObject+NLDBHelper.swift
//  NLSwipes
//
//  Created by NathanLi on 16/2/27.
//  Copyright © 2016年 NL. All rights reserved.
//

import Foundation
// MARK: - Database interface.
public extension NSObject {
  public var db_rowId: Int? {
    get {
      return objc_getAssociatedObject(self, &__key_dbRowId)?.integerValue
    }
    
    set {
      objc_setAssociatedObject(self, &__key_dbRowId, newValue != nil ? NSNumber(integer: newValue!) : nil, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }
  }
  
  /**
   * Save to database.
   */
  public func db_save() -> Bool {
    return false
  }
  
  /**
   * Update to database.
   */
  public func db_update() -> Bool {
    return false
  }
  
  /**
   * Insert to database.
   */
  public func db_insert() -> Bool {
    return false
  }
  
  /**
   *  Delete from database.
   */
  public func db_delete() -> Bool {
    return false
  }

  /**
   *  The model's table name in database.
   *  The default name is class name, you can override
   *  to change.
   */
  public static func db_tableName() -> String {
    return "\(self)"
  }
  
  /**
   The model's table primary key.
   
   - returns: Primary key name. Default is `rowid`, override to change it.
   */
  public static func db_primaryKey() -> String {
    return "rowid"
  }
  
  public static func db_search(options: [String:Any]?) -> [AnyObject]? {
    return nil
  }
  
  public static func db_searchSingle(option: [String:Any]?) -> AnyObject? {
    return nil
  }
  
  public static func db_execute(sql: String) -> Any? {
    return nil
  }
  
  public static func db_createTableSql() -> String? {
    return nil
  }
  
  func db_updateSql() -> String? {
    return nil
  }
  
  func db_insertSql() -> String? {
    return nil
  }
  
  func db_deleteSql() -> String? {
    return nil
  }
  
  func db_saveSql() -> String? {
    return nil
  }
}


private var __key_dbRowId: Void