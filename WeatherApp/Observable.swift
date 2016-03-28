//
//  Observable.swift
//  WeatherApp
//
//  Created by Jun Dang on 16/1/6.
//  Copyright © 2016年 Jun Dang. All rights reserved.
//

import Foundation

class Observable<T> {
    typealias Observer = T -> Void
    var observer: Observer?


func observe(observer: Observer?) {
    self.observer = observer
    observer?(value)
}

var value: T {
    didSet {
    observer?(value)
   }
}

init(_ v: T) {
    value = v
  }
}