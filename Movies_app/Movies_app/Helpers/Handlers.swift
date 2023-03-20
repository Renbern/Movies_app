// Handlers.swift
// Copyright © A.Shchukin. All rights reserved.

import Foundation

/// Псевдонимы замыканий
typealias VoidHandler = () -> ()
typealias IntHandler = (Int) -> (Void)
typealias ErrorHandler = (Error) -> (Void)
typealias Closure = ((String) -> Void)?
typealias StringHandler = (String) -> Void
typealias DataHandler = (Data) -> Void
