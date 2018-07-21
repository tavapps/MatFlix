//
//  UnwrapperProtocol.swift
//  MatFlix
//
//  Created by Matheus Tavares on 05/07/18.
//  Copyright © 2018 Matheus Tavares. All rights reserved.
//

import Foundation

protocol UnwrapperProtocol{
    func unwrap(_ any:Any) -> String
}

extension UnwrapperProtocol{
    func unwrap(_ any:Any) -> String {
        
        let mirror = Mirror(reflecting: any)
        
        if mirror.displayStyle != .optional {
            return String(describing:any)
        }
        
        if mirror.children.count == 0 { return "" }
        let (_, value) = mirror.children.first!
        return String(describing:value)
        
    }
}
