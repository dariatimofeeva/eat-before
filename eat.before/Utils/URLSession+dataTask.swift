//
//  URLSession+dataTask.swift
//  eat.before
//
//  Created by Екатерина Батеева on 31.07.2022.
//

import Foundation

extension URLSession {
    func dataTask(
        with url: URL,
        handler: @escaping (Result<Data, Error>) -> Void
    ) -> URLSessionDataTask {
        dataTask(with: url) { data, _, error in
            if let error = error {
                handler(.failure(error))
            } else {
                handler(.success(data ?? Data()))
            }
        }
    }
}
