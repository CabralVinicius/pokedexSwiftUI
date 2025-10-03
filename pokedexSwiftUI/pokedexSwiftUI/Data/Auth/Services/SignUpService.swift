//
//  SignUpService.swift
//  pokedexSwiftUI
//
//  Created by Vinicius Cabral on 03/10/25.
//

import Foundation

protocol SignUpServicing {
    func register(_ request: SignUpRequest) async throws -> User
}

enum SignUpError: Error {
    case invalidStatus(Int)
    case decoding
    case transport(Error)
}

final class SignUpService: SignUpServicing {
    private let session: URLSession
    private let baseURL: URL

    init(session: URLSession = .shared,
         baseURL: URL = URL(string: "https://api.seu-backend.com")!) {
        self.session = session
        self.baseURL = baseURL
    }

    func register(_ request: SignUpRequest) async throws -> User {
        var urlRequest = URLRequest(url: baseURL.appendingPathComponent("/auth/signup"))
        urlRequest.httpMethod = "POST"
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.httpBody = try JSONEncoder().encode(request)

        do {
            let (data, response) = try await session.data(for: urlRequest)
            guard let http = response as? HTTPURLResponse, (200...299).contains(http.statusCode) else {
                throw SignUpError.invalidStatus((response as? HTTPURLResponse)?.statusCode ?? -1)
            }
            do {
                return try JSONDecoder().decode(User.self, from: data)
            } catch {
                throw SignUpError.decoding
            }
        } catch {
            throw SignUpError.transport(error)
        }
    }
}
