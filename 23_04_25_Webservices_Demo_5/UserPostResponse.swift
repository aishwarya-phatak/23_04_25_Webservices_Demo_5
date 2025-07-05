//
//  UserPostResponse.swift
//  23_04_25_Webservices_Demo_5
//
//  Created by Vishal Jagtap on 05/07/25.
//

struct UserPostResponse : Decodable{
    var name : String
    var job : String
    var id : String
    var createdAt : String
}
