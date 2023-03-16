//
//  EmailService.swift
//  Vincent Lazzara
//
//  Created by Vinny Lazzara on 3/14/23.
//

import Foundation
import SendGrid
import Combine

class EmailService{
    
    func send(message: String)-> AnyPublisher<Bool, Error>{
        
        let apiKey = "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"
        
        let data: Data = {
            //Data
            let json: [String: Any] = [
                "personalizations": [["to": [["email": "vincent.a.lazzara@gmail.com"]]]],
                "from": ["email": "prodiggy1237@gmail.com"],
                "subject": "New App Contact Submisssion!",
                "content":[["type": "text/plain", "value": message]]
            
            ]
            return try! JSONSerialization.data(withJSONObject: json, options: [])
        }()

        
        let request: URLRequest = {
            let url = URL(string: "https://api.sendgrid.com/v3/mail/send")!
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.addValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpBody = data
            return request
        }()
        
        return URLSession.shared.dataTaskPublisher(for: request)
            .catch { error in
                return Fail(error: error).eraseToAnyPublisher()
            }.tryMap { output in
                let statusCode = (output.response as? HTTPURLResponse)?.statusCode ?? 0
                return (200...299).contains(statusCode)
            }.eraseToAnyPublisher()
        
        
        
        
    }
    
    
    
    
    
    
}
