//
//  NetworkWrapper.swift
//  HTW Mate
//
//  Created by Dennis Prudlo on 7/7/19.
//  Copyright © 2019 Dennis Prudlo. All rights reserved.
//

import Foundation

class NetworkWrapper {

//    v
//
//    static func postDownload(route: URLComponents, params: [String: String], completion: @escaping (URL?, URLResponse?, Error?) -> Void) {
//        guard let url = route.url else {
//            fatalError("api route could not be resolved (\(route))")
//        }
//
//        var request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 10.0)
//        request.httpMethod = "POST"
//        request.setValue("application/json", forHTTPHeaderField: "Accept")
//        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
//
//        var postString = ""
//        params.forEach { (key, value) in
//            postString.append("\(key)=\(value)&")
//        }
//        postString = String(postString.dropLast())
//
//        request.httpBody = postString.data(using: .utf8)
//
//        URLSession.shared.downloadTask(with: request) { (fileUrl, response, error) in
//            completion(fileUrl, response, error)
//            }.resume()
//    }

}
