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
}
