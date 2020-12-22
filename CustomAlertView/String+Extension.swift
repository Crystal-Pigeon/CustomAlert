//
//  String+Extension.swift
//  CustomAlertView
//
//  Created by Mariana Samardzic on 22.12.20..
//

import Foundation

extension String {
    var isBlank: Bool {
        return allSatisfy({ $0.isWhitespace })
    }
}
