//
//  String.swift
//  macro-qr-reader
//
//  Created by Clarence on 24/10/22.
//

import Foundation

extension String {
    func encodeBase64() -> String? {
        return data(using: .utf8)?.base64EncodedString()
    }

    func decodeBase64() -> String? {
        guard let data = Data(base64Encoded: self) else { return nil }
        return String(data: data, encoding: .utf8)
    }
}
