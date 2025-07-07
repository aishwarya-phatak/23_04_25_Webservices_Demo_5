//
//  ViewController.swift
//  23_04_25_Webservices_Demo_5
//
//  Created by Vishal Jagtap on 05/07/25.
//

import Alamofire
import UIKit

class ViewController: UIViewController {

    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var jobLabel: UILabel!
    @IBOutlet var jobTextField: UITextField!
    var baseUrl = "https://reqres.in"
    
    var urlStringForPost = "/api/users"
    var urlStringForPut = "/api/users/2"
    var urlStringForDelete = "/api/users/2"
    var url: URL?
    var urlRequest: URLRequest?
    
    var headers: HTTPHeaders =
        ["x-api-key": "reqres-free-v1"]

    var extractedName: String?
    var extractedJob: String?

    override func viewDidLoad() {
        super.viewDidLoad()
    
    }
    
    @IBAction func deleteUser(_ sender: UIButton ) {
        url = URL(string: baseUrl + urlStringForDelete)
        AF.request(url!,
                   method: .delete,
                   encoding: JSONEncoding.default,
                   headers: headers).response { response in
            print(response.response!.statusCode)
            switch response.result{
                case .success(let data):
                    print("Successfully deleted record")
                case .failure(let error):
                    print(error)
            }
        }
    }
    
    //PUT API  -- update user
    
    @IBAction func updateUserBtn(_ sender: UIButton) {
        url = URL(string: baseUrl + urlStringForPut)
        
        extractedName = self.nameTextField.text
        extractedJob = self.jobTextField.text
        
        var extractedParamerters = [
                                    "name" : extractedName!,
                                    "job" : extractedJob!
                                ]
        
        AF.request(url!,
                   method: .put,
                   parameters: extractedParamerters,
                   encoding: JSONEncoding.default,
                   headers: headers).response { response in
            switch response.result{
                case .success(let data) :
                    let putResponse = try! JSONDecoder().decode(UserPutResponse.self, from: data!)
                    print(putResponse)
                case .failure(let error) :
                    print(error)
            }
        }
    }
    
    //POST API -- post user
    @IBAction func loginBtn(_ sender: UIButton) {
        url = URL(string: baseUrl + urlStringForPost)
        
        extractedName = self.nameTextField.text
        extractedJob = self.jobTextField.text

        var extractedParameters = [
            "name": extractedName!,
            "job": extractedJob!,
        ]

        AF.request(
            url!,
            method: .post,
            parameters: extractedParameters,
            encoding: JSONEncoding.default,
            headers: headers
        ).response { response in
            switch response.result {
            case .success(let res):
                let postResponse = try! JSONDecoder().decode(UserPostResponse.self, from: res!)
                print(postResponse)
            case .failure(let error):
                print(error)
            }
        }
    }
}
