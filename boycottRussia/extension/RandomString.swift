//
//  File.swift
//  boycottRussia
//
//  Created by Oleksii Irzhavskyi on 17.07.2022.
//

import Foundation

func randomString(length: Int) -> String {
  let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
  return String((0..<length).map{ _ in letters.randomElement()! })
}
