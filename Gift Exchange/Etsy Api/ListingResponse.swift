//
//  ListingResponse.swift
//  Gift Exchange
//
//  Created by Crystal Ho on 7/6/21.
//

import Foundation

struct ListingResponse:Codable{
    let results:[Listing]
}
struct Listing:Codable{ //codable is used to convert Json
    let listing_id:Int
    let title:String
    let description:String
    let price:String
    let num_favorers:Int
    let url:String
}
