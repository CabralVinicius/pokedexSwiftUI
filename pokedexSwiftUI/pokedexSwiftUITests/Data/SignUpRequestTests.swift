//
//  SignUpRequestTests.swift
//  pokedexSwiftUITests
//
//  Created by Test Suite on 27/09/25.
//

//import Foundation
//import Testing
//@testable import pokedexSwiftUI
//
//@Suite("SignUpRequestTests")
//struct SignUpRequestTests {
//    
//    // MARK: - Initialization Tests
//    
//    @Test
//    func testInitialization() {
//        // Given
//        let email = "test@example.com"
//        let password = "password123"
//        let name = "Test User"
//        
//        // When
//        let request = SignUpRequest(email: email, password: password, name: name)
//        
//        // Then
//        #expect(request.email == email)
//        #expect(request.password == password)
//        #expect(request.name == name)
//    }
//    
//    @Test
//    func testInitializationWithEmptyStrings() {
//        // Given
//        let email = ""
//        let password = ""
//        let name = ""
//        
//        // When
//        let request = SignUpRequest(email: email, password: password, name: name)
//        
//        // Then
//        #expect(request.email == email)
//        #expect(request.password == password)
//        #expect(request.name == name)
//    }
//    
//    @Test
//    func testInitializationWithSpecialCharacters() {
//        // Given
//        let email = "user.name+tag@domain.co.uk"
//        let password = "P@ssw0rd!@#$%^&*()"
//        let name = "José María O'Connor-Smith"
//        
//        // When
//        let request = SignUpRequest(email: email, password: password, name: name)
//        
//        // Then
//        #expect(request.email == email)
//        #expect(request.password == password)
//        #expect(request.name == name)
//    }
//    
//    // MARK: - Encoding Tests
//    
//    @Test
//    func testJSONEncoding() throws {
//        // Given
//        let request = SignUpRequest(
//            email: "test@example.com",
//            password: "password123",
//            name: "Test User"
//        )
//        
//        // When
//        let jsonData = try JSONEncoder().encode(request)
//        let jsonString = String(data: jsonData, encoding: .utf8)
//        
//        // Then
//        #expect(jsonString != nil)
//        let s = try #require(jsonString)
//        #expect(s.contains("test@example.com"))
//        #expect(s.contains("password123"))
//        #expect(s.contains("Test User"))
//        #expect(s.contains("email"))
//        #expect(s.contains("password"))
//        #expect(s.contains("name"))
//    }
//    
//    @Test
//    func testJSONEncodingRoundTrip() throws {
//        // Given
//        let originalRequest = SignUpRequest(
//            email: "test@example.com",
//            password: "password123",
//            name: "Test User"
//        )
//        
//        // When
//        let jsonData = try JSONEncoder().encode(originalRequest)
//        let decodedRequest = try JSONDecoder().decode(SignUpRequest.self, from: jsonData)
//        
//        // Then
//        #expect(decodedRequest.email == originalRequest.email)
//        #expect(decodedRequest.password == originalRequest.password)
//        #expect(decodedRequest.name == originalRequest.name)
//    }
//    
//    @Test
//    func testJSONEncodingWithUnicodeCharacters() throws {
//        // Given
//        let request = SignUpRequest(
//            email: "josé@exemplo.com",
//            password: "senha123",
//            name: "João da Silva"
//        )
//        
//        // When
//        let jsonData = try JSONEncoder().encode(request)
//        let decodedRequest = try JSONDecoder().decode(SignUpRequest.self, from: jsonData)
//        
//        // Then
//        #expect(decodedRequest.email == request.email)
//        #expect(decodedRequest.password == request.password)
//        #expect(decodedRequest.name == request.name)
//    }
//    
//    // MARK: - Validation Tests
//    
//    @Test
//    func testValidEmailFormats() {
//        let validEmails = [
//            "test@example.com",
//            "user.name@domain.co.uk",
//            "user+tag@example.org",
//            "firstname-lastname@example.com",
//            "email@subdomain.example.com",
//            "firstname+lastname@example.com",
//            "email@123.123.123.123",
//            "email@[123.123.123.123]",
//            "1234567890@example.com",
//            "email@example-one.com",
//            "_______@example.com",
//            "email@example.name",
//            "email@example.museum",
//            "email@example.co.jp",
//            "firstname-lastname@example.com"
//        ]
//        
//        for email in validEmails {
//            let request = SignUpRequest(email: email, password: "password123", name: "Test User")
//            #expect(request.email == email, "Failed for email: \(email)")
//        }
//    }
//    
//    @Test
//    func testPasswordLengthVariations() {
//        let passwords = [
//            "12345678", // Minimum length
//            "password123",
//            "P@ssw0rd!@#$%^&*()",
//            "verylongpasswordthatexceedstypicallimits",
//            "a".repeating(100) // Very long password
//        ]
//        
//        for password in passwords {
//            let request = SignUpRequest(email: "test@example.com", password: password, name: "Test User")
//            #expect(request.password == password, "Failed for password length: \(password.count)")
//        }
//    }
//    
//    @Test
//    func testNameVariations() {
//        let names = [
//            "John",
//            "John Doe",
//            "José María",
//            "Jean-Pierre O'Connor",
//            "李小明",
//            "François Müller",
//            "A", // Single character
//            "Very Long Name That Exceeds Typical Limits And Goes On And On",
//            "  Trimmed  " // With whitespace
//        ]
//        
//        for name in names {
//            let request = SignUpRequest(email: "test@example.com", password: "password123", name: name)
//            #expect(request.name == name, "Failed for name: \(name)")
//        }
//    }
//    
//    // MARK: - Edge Cases Tests
//    
//    @Test
//    func testEmptyRequest() {
//        // Given & When
//        let request = SignUpRequest(email: "", password: "", name: "")
//        
//        // Then
//        #expect(request.email == "")
//        #expect(request.password == "")
//        #expect(request.name == "")
//    }
//    
//    @Test
//    func testWhitespaceOnlyRequest() {
//        // Given
//        let whitespace = "   \t\n   "
//        
//        // When
//        let request = SignUpRequest(email: whitespace, password: whitespace, name: whitespace)
//        
//        // Then
//        #expect(request.email == whitespace)
//        #expect(request.password == whitespace)
//        #expect(request.name == whitespace)
//    }
//    
//    @Test
//    func testVeryLongStrings() {
//        // Given
//        let longString = String(repeating: "a", count: 1000)
//        
//        // When
//        let request = SignUpRequest(email: longString, password: longString, name: longString)
//        
//        // Then
//        #expect(request.email.count == 1000)
//        #expect(request.password.count == 1000)
//        #expect(request.name.count == 1000)
//    }
//    
//    // MARK: - Performance Tests (converted to functional loops)
//    
//    @Test
//    func testInitializationPerformance() {
//        // Run initialization repeatedly to ensure no regressions/crashes
//        for i in 0..<1000 {
//            _ = SignUpRequest(
//                email: "test\(i)@example.com",
//                password: "password\(i)",
//                name: "User \(i)"
//            )
//        }
//    }
//    
//    @Test
//    func testJSONEncodingPerformance() throws {
//        // Given
//        let request = SignUpRequest(
//            email: "test@example.com",
//            password: "password123",
//            name: "Test User"
//        )
//        
//        // Run encoding repeatedly to ensure no regressions/crashes
//        for _ in 0..<1000 {
//            _ = try JSONEncoder().encode(request)
//        }
//    }
//    
//    @Test
//    func testJSONDecodingPerformance() throws {
//        // Given
//        let request = SignUpRequest(
//            email: "test@example.com",
//            password: "password123",
//            name: "Test User"
//        )
//        let jsonData = try JSONEncoder().encode(request)
//        
//        // Run decoding repeatedly to ensure no regressions/crashes
//        for _ in 0..<1000 {
//            _ = try JSONDecoder().decode(SignUpRequest.self, from: jsonData)
//        }
//    }
//}
//
//// MARK: - Helper Extensions
//
//private extension String {
//    func repeating(_ count: Int) -> String {
//        return String(repeating: self, count: count)
//    }
//}
