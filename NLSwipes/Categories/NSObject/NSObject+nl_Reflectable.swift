//
//  NSObject+nl_Reflectable.swift
//  NLSwipes
//
//  Created by NathanLi on 16/1/8.
//  Copyright © 2016年 NL. All rights reserved.
//

import Foundation


public protocol NLToDictionary {}
public extension NLToDictionary  {
  public func nl_toDictionary(containParent: Bool) -> [String: Any] {
    return __nl_toDictionaryWith(Mirror(reflecting: self), containParent: containParent)
  }
  
  private func __nl_toDictionaryWith(mirror: Mirror, containParent: Bool) -> [String: Any] {
    var result = [String: Any]()
    mirror.children.filter {
      $0.label != nil
      }.forEach {
        result[$0!] = $1
    }
    
    if containParent && mirror.superclassMirror() != nil {
      let superMirror = mirror.superclassMirror()
      let superDictionary = __nl_toDictionaryWith(superMirror!, containParent: true)
      superDictionary.forEach {
        result[$0] = $1
      }
    }
    
    return result
  }

}

/// Class property information. Include the property name and it's type name.
public typealias NLPropertyInfo = (name: String, typeName: String)

extension NSObject: NLToDictionary {
  
}

// MARK: - The property informas.
public extension NSObject {
  
  /**
   Property names.
   
   - returns: Array include property names.
   */
  public class func nl_propertyNames() -> [String] {
    var propertyNames = self.__nl_typeNameDictionarys[self.nl_typeName()];
    
    if (propertyNames == nil) {
      propertyNames = self.nl_propertyInfos().map { $0.name }
      self.__nl_typeNameDictionarys[self.nl_typeName()] = propertyNames
    }
    
    return propertyNames!;
  }
  
  /**
   Property informations.
   
   - returns: Array include property informations.
   */
  public class func nl_propertyInfos() -> [NLPropertyInfo] {
    var propertyInfos = self.__nl_typePropertyDictionarys[self.nl_typeName()];
    
    if (propertyInfos == nil) {
      propertyInfos = self.__nl_propertyInfos(Mirror(reflecting:self.init()));
      self.__nl_typePropertyDictionarys[self.nl_typeName()] = propertyInfos;
    }

    return propertyInfos!;
  }
  
  /**
   Query property type name.
   
   - parameter name: The property name
   
   - returns: String? of property type name.
   */
  public class func nl_typeNameWithPropertyName(name: String) -> String? {
    for propertyInfo in self.nl_propertyInfos() {
      if (propertyInfo.name == name) {
        let typeName = propertyInfo.typeName
        return typeName
      }
    }
    
    return nil;
  }
  
  /**
   Class name
   
   - returns: String of current class name.
   */
  public class func nl_typeName() -> String {
    return "\(self)"
  }
  
  private class func __nl_propertyInfos(mirror: Mirror) -> [NLPropertyInfo] {
    var variableInfos = mirror.children.filter { $0.label != nil }.map { NLPropertyInfo($0.label!, "\($0.value.dynamicType)") }
    
    if let superMirror = mirror.superclassMirror() {
      variableInfos.appendContentsOf(self.__nl_propertyInfos(superMirror));
    }
    
    return variableInfos ?? [];
  }
  
  
  private static var __nl_typePropertyDictionarys = Dictionary<String, [NLPropertyInfo]>();
  private static var __nl_typeNameDictionarys = Dictionary<String, [String]>();
}

extension NSObject {
  
}