//
//  +UITextView.swift
//  NotesApp
//
//  Created by Семен Гайдамакин on 30.01.2024.
//

import UIKit

extension UITextView {
    
    func getFirstLine() -> String {
        var firstLine = ""
        guard let text = self.text, !text.isEmpty else { return ""}
        
        let lines = text.components(separatedBy: "\n")
       
        guard let title = lines.first else { return "" }
        firstLine = title
        return firstLine
    }
    
    func getTextWithoutTitle() -> String {
        guard let text = self.text, !text.isEmpty else { return ""}
        let lines = text.components(separatedBy: "\n")
        
        let textWithoutTitle = lines.dropFirst().joined(separator: "\n")
        
        return textWithoutTitle
    }
    
    func numberOfLines() -> Int {
          guard let attributedText = self.attributedText else { return 0 }

          let textStorage = NSTextStorage(attributedString: attributedText)
          let layoutManager = NSLayoutManager()
          textStorage.addLayoutManager(layoutManager)

          let textContainer = NSTextContainer(size: self.bounds.size)
          layoutManager.addTextContainer(textContainer)

          var numberOfLines = 0
          var index = 0
          var lineRange = NSRange()

          while index < layoutManager.numberOfGlyphs {
              layoutManager.lineFragmentRect(forGlyphAt: index, effectiveRange: &lineRange)
              index = NSMaxRange(lineRange)
              numberOfLines += 1
          }

          return numberOfLines
      }
}
