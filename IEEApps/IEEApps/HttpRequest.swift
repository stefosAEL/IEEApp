//
//  HttpRequest.swift
//  IEEApps
//
//  Created by Stefanos Kafkalias on 30/03/2022.
//

import UIKit
// Prepare URL
let url = URL(string: "https://jsonplaceholder.typicode.com/todos")
guard let requestUrl = url else { fatalError() }
// Prepare URL Request Object
var request = URLRequest(url: requestUrl)
request.httpMethod = "POST"
 
// HTTP Request Parameters which will be sent in HTTP Request Body
let postString = "userId=300&title=My urgent task&completed=false";
// Set HTTP Request Body
request.httpBody = postString.data(using: String.Encoding.utf8);
// Perform HTTP Request
let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
        
        // Check for Error
        if let error = error {
            print("Error took place \(error)")
            return
        }
 
        // Convert HTTP Response Data to a String
        if let data = data, let dataString = String(data: data, encoding: .utf8) {
            print("Response data string:\n \(dataString)")
        }
}
task.resume()

