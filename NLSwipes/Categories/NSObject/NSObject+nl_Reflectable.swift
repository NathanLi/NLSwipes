//
//  NSObject+nl_Reflectable.swift
//  NLSwipes
//
//  Created by NathanLi on 16/1/8.
//  Copyright © 2016年 NL. All rights reserved.
//

import Foundation
import ObjectiveC

public typealias NLPropertyInfo = (name: String, typeName: String)
public extension NSObject {
  
  public class func nl_propertyNames() -> [String] {
    var propertyNames = self.__nl_typeNameDictionarys[self.nl_typeName()];
    
    if (propertyNames == nil) {
      propertyNames = self.nl_propertyInfos().map { $0.name }
      self.__nl_typeNameDictionarys[self.nl_typeName()] = propertyNames
    }
    
    return propertyNames!;
  }
  
  public class func nl_propertyInfos() -> [NLPropertyInfo] {
    var propertyInfos = self.__nl_typeVarDictionarys[self.nl_typeName()];
    
    if (propertyInfos == nil) {
      propertyInfos = self.__nl_variableInfos(Mirror(reflecting:self.init()));
      self.__nl_typeVarDictionarys[self.nl_typeName()] = propertyInfos;
    }

    return propertyInfos!;
  }
  
  public class func nl_typeNameWithPropertyName(name: String) -> String? {
    for propertyInfo in self.nl_propertyInfos() {
      if (propertyInfo.name == name) {
        let typeName = propertyInfo.typeName
        return typeName
      }
    }
    
    return nil;
  }
  
  public class func nl_typeName() -> String {
    return "\(self)"
  }
  
  
  private class func __nl_variableInfos(mirror: Mirror) -> [NLPropertyInfo] {
    var variableInfos = mirror.children.filter { $0.label != nil }.map { NLPropertyInfo($0.label!, "\($0.value.dynamicType)") }
    
    if let superMirror = mirror.superclassMirror() {
      variableInfos.appendContentsOf(self.__nl_variableInfos(superMirror));
    }
    
    return variableInfos ?? [];
  }
  
  
  private static var __nl_typeVarDictionarys = Dictionary<String, [NLPropertyInfo]>();
  private static var __nl_typeNameDictionarys = Dictionary<String, [String]>();
}

extension NSObject {
  
}