//
//  imageResponse.swift
//  Gift Exchange
//
//  Created by Crystal Ho on 7/8/21.
//

import Foundation

struct imageResponse:Codable{
    let results:[imageList]
}
struct imageList:Codable{ //codable is used to convert Json
    let url_fullxfull:String
}
