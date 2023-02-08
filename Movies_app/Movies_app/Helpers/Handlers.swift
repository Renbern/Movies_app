//
//  Handlers.swift
//  Movies_app
//
//  Created by Артур Щукин on 08.02.2023.
//

import Foundation

/// Псевдонимы замыканий
typealias VoidHandler = () -> ()
typealias IntHandler = (Int) -> (Void)
typealias ErrorHandler = (Error) -> (Void)
typealias Closure = ((String) -> Void)?
