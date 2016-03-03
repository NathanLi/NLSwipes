//
//  AppDelegate.swift
//  NLSwipes
//
//  Created by NathanLi on 15/12/28.
//  Copyright © 2015年 NL. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?

  func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
    print(NLTagModel.nl_propertyNames());
    for name in NLTagModel.nl_propertyNames() {
      let a = NLTagModel.nl_typeNameWithPropertyName(name)
      print(a!)
    }
    
    print(NLTagModel.db_tableName())
    
    let tagModel = NLTagModel()
    print(tagModel.nl_toDictionary(true))
    return true
  }

}

