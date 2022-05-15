//
//  URLSession+Compatibility.swift
//  iOS Demo
//
//  Created by Mo Moosa on 15/05/2022.
//

import Foundation

extension URLSession {
    @available(iOS, deprecated: 15.0, message: "Use `try await URLSession.shared.data(from: url)` instead ")
    func dataWithCompatibilityAPI(from request: URLRequest) async throws -> (Data, URLResponse) {

        // Suspends this task until the callback returns a response
        try await withCheckedThrowingContinuation { continuation in
            let task = self.dataTask(with: request) { data, response, error in
                guard let data = data, let response = response else {
                    let error = error ?? URLError(.badServerResponse)
                    return continuation.resume(throwing: error)
                }

                continuation.resume(returning: (data, response))
            }

            task.resume()
        }
    }
}
