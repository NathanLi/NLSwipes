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
      let a: AnyClass? = NLTagModel.nl_typeWithName(name)
      print(a)
    }
    return true
  }

}

