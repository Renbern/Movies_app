// Handlers.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Псевдонимы замыканий
typealias VoidHandler = () -> ()
typealias IntHandler = (Int) -> (Void)
typealias ErrorHandler = (Error) -> (Void)
typealias Closure = ((String) -> Void)?
typealias DataHandler = (Data) -> Void
