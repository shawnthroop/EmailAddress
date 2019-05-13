//
//  EmailAddress.swift
//  EmailAddress
//
//  Created by Shawn Throop on 13.05.19.
//

import Foundation

/// A value representing a properly formatted email address.
public struct EmailAddress: Equatable, Hashable {
    
    public enum FormatError: Error {
        case atSymbolNotFound
        case invalid
    }
    
    public let at: Range<String.Index>
    public let ext: Range<String.Index>?
    
    public let rawValue: String
    
    
    public init(_ rawValue: String) throws {
        let range = NSRange(rawValue.startIndex..<rawValue.endIndex, in: rawValue)
        
        guard let result = NSRegularExpression.email.firstMatch(in: rawValue, range: range), result.numberOfRanges == 4 else {
            throw FormatError.invalid
        }
        
        guard let at = Range(result.range(at: 2), in: rawValue), rawValue[at] == "@" else {
            throw FormatError.atSymbolNotFound
        }
        guard
            let local = Range(result.range(at: 1), in: rawValue), local.lowerBound == rawValue.startIndex,
            let remote = Range(result.range(at: 3), in: rawValue) else {
                throw FormatError.invalid
        }
        
        self.init(local: String(rawValue[local]), remote: String(rawValue[remote]))
    }
}


public extension EmailAddress {
    var local: Substring {
        return rawValue[..<at.lowerBound]
    }
    
    var remote: Substring {
        return rawValue[at.upperBound...]
    }
    
    var `extension`: Substring? {
        return ext.map { rawValue[$0] }
    }
}


extension EmailAddress: RawRepresentable {
    public typealias RawValue = String
    
    public init?(rawValue: RawValue) {
        guard let email = try? EmailAddress(rawValue) else {
            return nil
        }
        
        self = email
    }
}


private extension EmailAddress {
    init(local: String, remote: String) {
        self.init(rawValue: "\(local)@\(remote)", at: local.endIndex)
    }
    
    private init(rawValue: String, at atStartIndex: String.Index) {
        let remote = rawValue.index(after: atStartIndex)..<rawValue.endIndex
        let ext = rawValue.range(of: ".", options: .backwards, range: remote).map { $0.upperBound..<rawValue.endIndex }
        
        self.at = atStartIndex..<remote.lowerBound
        self.ext = rawValue.last == "]" ? nil : ext // if address is example@[192.168.0.1]
        self.rawValue = rawValue
    }
}
