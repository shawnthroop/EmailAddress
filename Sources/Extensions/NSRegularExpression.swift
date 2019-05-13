//
//  NSRegularExpression.swift
//  EmailAddress
//
//  Created by Shawn Throop on 13.05.19.
//

import Foundation

extension NSRegularExpression {
    public static let email = try! NSRegularExpression(pattern: emailRegex, options: [])
}

/*
 # Capture Groups for "example@company.tld":
    0. Entire match - example@company.tld"
    1. Local        - example
    2. @            - @
    3. Remote       - company.tld"
 
 Adapted from: http://emailregex.com
 - Note: Also valid yet odd cases: example@[192.168.0.3], "Mr.Smith"@company.co
*/

private let emailRegex: String = #"""
([a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")(@)((?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])
"""#
