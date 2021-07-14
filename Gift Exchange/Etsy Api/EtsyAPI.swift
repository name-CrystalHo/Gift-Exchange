//
//  EtsyAPI.swift
//  Gift Exchange
//
//  Created by Crystal Ho on 7/1/21.
//

import UIKit

class EtsyAPI{
    let keyString = "v015vmeipeqktwdlwfxz7t5w"
    let listingEndPoint = "https://openapi.etsy.com/v2/listings/active?api_key=v015vmeipeqktwdlwfxz7t5w"
    //escaping means the completion isn't always called
    func getListings(completion:@escaping ([Listing]) -> Void){ //getListing will pass in function that takes in Listing array and returns nothing
        guard let url = URL(string: listingEndPoint)else{
            return
        }
        let request = URLRequest(url: url)
        let myTask = URLSession.shared.dataTask(with: request, completionHandler: {data,response,error in
            if let error = error {
                print("oops")
            }
            guard let data = data else{ //null check
                print("oops")
                return
            }
        
            //? means could fail, a lot safer
            //! screw swift never gonna fail, bad practice tho
            guard let response = response as? HTTPURLResponse else{
                print("oops")
                return
            }
            //200 success
            //300 cache
            guard response.statusCode >= 200, response.statusCode <= 399 else{
                print("oops")
                return
            }
            let decoder = JSONDecoder()
            do{
                let myListingResponse = try decoder.decode(ListingResponse.self, from: data) //convertes data
                completion(myListingResponse.results) //passes converted to function
            } catch {
                print("error")
            }
        })
        myTask.resume()
    }
    func getImages(id:Int,completion:@escaping ([imageList]) -> Void){
        let imagesEndPoint = "https://openapi.etsy.com/v2/listings/\(id)/images?api_key=v015vmeipeqktwdlwfxz7t5w"
        guard let url  = URL(string: imagesEndPoint)else{
            return
        }
        let request = URLRequest(url: url)
        let myTask = URLSession.shared.dataTask(with: request, completionHandler: {data,response,error in
            if let error = error {
                print("oops")
            }
            guard let data = data else{ //null check
                print("oops")
                return
            }
        
            //? means could fail, a lot safer
            //! screw swift never gonna fail, bad practice tho
            guard let response = response as? HTTPURLResponse else{
                print("oops")
                return
            }
            //200 success
            //300 cache
            guard response.statusCode >= 200, response.statusCode <= 399 else{
                print("oops")
                return
            }
            let decoder = JSONDecoder()
            do{
                let myImageResponse = try decoder.decode(imageResponse.self, from: data) //convertes data
                completion(myImageResponse.results) //passes converted to function
            } catch {
                print("error")
            }
        })
        myTask.resume()
    }
}
