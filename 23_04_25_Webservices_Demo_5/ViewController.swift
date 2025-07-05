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
    var urlString = "https://reqres.in/api/users"
    var url: URL?
    var urlRequest: URLRequest?

    var headers: HTTPHeaders =
        ["x-api-key": "reqres-free-v1"]

    var extractedName: String?
    var extractedJob: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        url = URL(string: urlString)
        urlRequest = URLRequest(url: url!)
    }

    @IBAction func loginBtn(_ sender: UIButton) {
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
