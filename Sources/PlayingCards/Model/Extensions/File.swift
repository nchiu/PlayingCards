//
//  File.swift
//  
//
//  Created by Nathan Chiu on 6/22/23.
//

import Foundation

extension Int {
	var isEven: Bool {
		isMultiple(of: 2)
	}

	var isOdd: Bool {
		!isEven
	}
}
