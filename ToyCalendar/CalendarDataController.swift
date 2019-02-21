//
//  CalendarDataController.swift
//  ToyCalendar
//
//  Created by sdondon on 21/02/2019.
//  Copyright © 2019 YAPP. All rights reserved.
//

import Foundation

class CalendarData {
    var dummyString: String = ""
}

class CalendarDataController {
    private let requestor: TCApiRequest = TCApiRequest()
    
    func requestData(completion: @escaping (CalendarData?) -> Void) {
        let queryItems: [URLQueryItem] = [URLQueryItem(name: "postId", value: "1")]
        
        requestor.cancel()
        requestor.baseURLPath = "https://jsonplaceholder.typicode.com/comments"
        requestor.fetch(with: queryItems) { [weak self] data, error in
            let completionInMainThread = { (completion: @escaping (CalendarData?) -> Void, result: CalendarData?) in
                DispatchQueue.main.async {
                    completion(result)
                }
            }
            
            guard let data = data, error == nil else {
                completionInMainThread(completion, nil)
                return
            }
            
            do {
                let calendar: CalendarData? = try self?.parseCalendar(with: data)
                completionInMainThread(completion, calendar)
            } catch {
                completionInMainThread(completion, nil)
            }
        }
    }
}

extension CalendarDataController {
    private func parseCalendar(with data: Data?) throws -> CalendarData? {
        guard let data = data, let jsons = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [[String: Any]] else {
            return nil
        }
        
        print(jsons)
        return CalendarData()
    }
}
