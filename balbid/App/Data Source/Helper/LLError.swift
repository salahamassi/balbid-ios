//
//  LLError.swift
//  MSA
//
//  Created by Salah Amassi on 5/4/20.
//  Copyright © 2020 winch. All rights reserved.
//
import Foundation

public class LLError: Error {

    public var message: String

    public init(message: String) {
        self.message = message
    }

}

public extension Error {
    func convertToWinchError() -> LLError {
        return LLError(message: localizedDescription)
    }
}
