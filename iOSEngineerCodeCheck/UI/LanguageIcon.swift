import UIKit

enum LanguageIcon {
    case c
    case cpp
    case cs
    case css
    case dart
    case go
    case html
    case java
    case javaScript
    case kotlin
    case objectiveC
    case php
    case python
    case r
    case ruby
    case rust
    case swift
    case typeScript
    case other
    
    init(language: String) {
        switch language {
        case "C":           self = .c
        case "C++":         self = .cpp
        case "C#":          self = .cs
        case "CSS":         self = .css
        case "Dart":        self = .dart
        case "Go":          self = .go
        case "HTML":        self = .html
        case "Java":        self = .java
        case "JavaScript":  self = .javaScript
        case "Kotlin":      self = .kotlin
        case "Objective-C": self = .objectiveC
        case "PHP":         self = .php
        case "Python":      self = .python
        case "R":           self = .r
        case "Ruby":        self = .ruby
        case "Rust":        self = .rust
        case "Swift":       self = .swift
        case "TypeScript":  self = .typeScript
        default:            self = .other
        }
    }
    
    var color: UIColor {
        switch self {
        case .c:            return UIColor(hex: "555555")
        case .cpp:          return UIColor(hex: "178600")
        case .cs:           return UIColor(hex: "f34b7d")
        case .css:          return UIColor(hex: "563d7c")
        case .dart:         return UIColor(hex: "00b4ab")
        case .go:           return UIColor(hex: "375eab")
        case .html:         return UIColor(hex: "e44b23")
        case .java:         return UIColor(hex: "b07219")
        case .javaScript:   return UIColor(hex: "f1e05a")
        case .kotlin:       return UIColor(hex: "ea4dfa")
        case .objectiveC:   return UIColor(hex: "438eff")
        case .php:          return UIColor(hex: "4f5d95")
        case .python:       return UIColor(hex: "3572a5")
        case .r:            return UIColor(hex: "198ce7")
        case .ruby:         return UIColor(hex: "701516")
        case .rust:         return UIColor(hex: "dea584")
        case .swift:        return UIColor(hex: "ffac45")
        case .typeScript:   return UIColor(hex: "2b7489")
        case .other:        return UIColor(hex: "333333")
        }
    }
}
