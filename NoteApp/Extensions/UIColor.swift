//
//  UIColor.swift
//  NoteApp
//
//  Created by Rumeysa Tokur on 11.03.2025.
//

import Foundation
import UIKit

extension UIColor{
    convenience init(hex: String) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        if hexSanitized.hasPrefix("#") {
            hexSanitized.remove(at: hexSanitized.startIndex)
        }
        guard hexSanitized.count == 6 else {
            self.init(white: 0.0, alpha: 1.0)
            return
        }
        var rgbValue: UInt64 = 0
        Scanner(string: hexSanitized).scanHexInt64(&rgbValue)
        self.init(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: 1.0
        )
    }
    
    var hexString: String {
        guard let components = cgColor.components else { return "#000000" }
        
        if cgColor.numberOfComponents == 2 {
        
            let white = Int(components[0] * 255)
            return String(format: "#%02X%02X%02X",
                          white,
                          white,
                          white)
        } else if cgColor.numberOfComponents >= 3 {
            // RGB
            let r = Int(components[0] * 255)
            let g = Int(components[1] * 255)
            let b = Int(components[2] * 255)
            return String(format: "#%02X%02X%02X",
                          r,
                          g,
                          b)
        }
        
        return "#000000"
    }
    

    
}
