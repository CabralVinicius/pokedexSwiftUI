//
//  SignUpViewModelTests.swift
//  pokedexSwiftUITests
//
//  Created by Test Suite on 27/09/25.
//

import XCTest
import Combine
@testable import pokedexSwiftUI

@MainActor
final class SignUpViewModelTests: XCTestCase {
    
    private var viewModel: SignUpViewModel!
    private var mockService: MockSignUpService!
    private var cancellables: Set<AnyCancellable>!
    
    override func setUp() {
        super.setUp()
        mockService = MockSignUpService()
        viewModel = SignUpViewModel(service: mockService, animator: .none)
        cancellables = []
    }
    
    override func tearDown() {
        cancellables = nil
        viewModel = nil
        mockService = nil
        super.tearDown()
    }
    
    // MARK: - Initialization Tests
    
    func testInitialState() {
        XCTAssertEqual(viewModel.email, "")
        XCTAssertEqual(viewModel.password, "")
        XCTAssertEqual(viewModel.name, "")
        XCTAssertEqual(viewModel.step, .email)
        XCTAssertFalse(viewModel.showPassword)
        XCTAssertFalse(viewModel.isLoading)
        XCTAssertNil(viewModel.errorMessage)
    }
    
    // MARK: - Step Navigation Tests
    
    func testNextStepFromEmail() {
        // Given
        XCTAssertEqual(viewModel.step, .email)
        
        // When
        viewModel.nextStep()
        
        // Then
        XCTAssertEqual(viewModel.step, .password)
    }
    
    func testNextStepFromPassword() {
        // Given
        viewModel.step = .password
        
        // When
        viewModel.nextStep()
        
        // Then
        XCTAssertEqual(viewModel.step, .name)
    }
    
    func testNextStepFromName() {
        // Given
        viewModel.step = .name
        
        // When
        viewModel.nextStep()
        
        // Then
        XCTAssertEqual(viewModel.step, .name) // Should stay on last step
    }
    
    func testPreviousStepFromPassword() {
        // Given
        viewModel.step = .password
        
        // When
        viewModel.previousStep()
        
        // Then
        XCTAssertEqual(viewModel.step, .email)
    }
    
    func testPreviousStepFromName() {
        // Given
        viewModel.step = .name
        
        // When
        viewModel.previousStep()
        
        // Then
        XCTAssertEqual(viewModel.step, .password)
    }
    
    func testPreviousStepFromEmail() {
        // Given
        viewModel.step = .email
        
        // When
        viewModel.previousStep()
        
        // Then
        XCTAssertEqual(viewModel.step, .email) // Should stay on first step
    }
    
    // MARK: - Validation Tests
    
    func testEmailValidation() {
        // Given
        viewModel.step = .email
        
        // Test invalid emails
        viewModel.email = "invalid"
        XCTAssertFalse(viewModel.isContinueEnabled)
        
        viewModel.email = "test@"
        XCTAssertFalse(viewModel.isContinueEnabled)
        
        viewModel.email = "@domain.com"
        XCTAssertFalse(viewModel.isContinueEnabled)
        
        // Test valid emails
        viewModel.email = "test@example.com"
        XCTAssertTrue(viewModel.isContinueEnabled)
        
        viewModel.email = "user.name+tag@domain.co.uk"
        XCTAssertTrue(viewModel.isContinueEnabled)
    }
    
    func testPasswordValidation() {
        // Given
        viewModel.step = .password
        
        // Test invalid passwords
        viewModel.password = "123"
        XCTAssertFalse(viewModel.isContinueEnabled)
        
        viewModel.password = "1234567"
        XCTAssertFalse(viewModel.isContinueEnabled)
        
        // Test valid passwords
        viewModel.password = "12345678"
        XCTAssertTrue(viewModel.isContinueEnabled)
        
        viewModel.password = "password123"
        XCTAssertTrue(viewModel.isContinueEnabled)
    }
    
    func testNameValidation() {
        // Given
        viewModel.step = .name
        
        // Test invalid names
        viewModel.name = ""
        XCTAssertFalse(viewModel.isContinueEnabled)
        
        viewModel.name = "A"
        XCTAssertFalse(viewModel.isContinueEnabled)
        
        viewModel.name = "   "
        XCTAssertFalse(viewModel.isContinueEnabled)
        
        viewModel.name = " A "
        XCTAssertFalse(viewModel.isContinueEnabled)
        
        // Test valid names
        viewModel.name = "João"
        XCTAssertTrue(viewModel.isContinueEnabled)
        
        viewModel.name = "Maria Silva"
        XCTAssertTrue(viewModel.isContinueEnabled)
        
        viewModel.name = "  João Silva  " // Should trim whitespace
        XCTAssertTrue(viewModel.isContinueEnabled)
    }
    
    // MARK: - Request Creation Tests
    
    func testMakeRequest() {
        // Given
        viewModel.email = "test@example.com"
        viewModel.password = "password123"
        viewModel.name = "Test User"
        
        // When
        let request = viewModel.makeRequest()
        
        // Then
        XCTAssertEqual(request.email, "test@example.com")
        XCTAssertEqual(request.password, "password123")
        XCTAssertEqual(request.name, "Test User")
    }
    
    // MARK: - Submit Tests
    
    func testSubmitSuccess() async {
        // Given
        viewModel.email = "test@example.com"
        viewModel.password = "password123"
        viewModel.name = "Test User"
        viewModel.step = .name
        
        let expectedUser = User(id: "123", email: "test@example.com", name: "Test User")
        mockService.mockUser = expectedUser
        
        // When
        let result = await viewModel.submit()
        
        // Then
        XCTAssertNotNil(result)
        XCTAssertEqual(result?.id, expectedUser.id)
        XCTAssertEqual(result?.email, expectedUser.email)
        XCTAssertEqual(result?.name, expectedUser.name)
        XCTAssertFalse(viewModel.isLoading)
        XCTAssertNil(viewModel.errorMessage)
    }
    
    func testSubmitWithInvalidData() async {
        // Given
        viewModel.email = "invalid"
        viewModel.password = "123"
        viewModel.name = "A"
        viewModel.step = .name
        
        // When
        let result = await viewModel.submit()
        
        // Then
        XCTAssertNil(result)
        XCTAssertFalse(viewModel.isLoading)
    }
    
    func testSubmitWithServiceError() async {
        // Given
        viewModel.email = "test@example.com"
        viewModel.password = "password123"
        viewModel.name = "Test User"
        viewModel.step = .name
        
        mockService.mockError = SignUpError.invalidStatus(400)
        
        // When
        let result = await viewModel.submit()
        
        // Then
        XCTAssertNil(result)
        XCTAssertFalse(viewModel.isLoading)
        XCTAssertNotNil(viewModel.errorMessage)
        XCTAssertTrue(viewModel.errorMessage?.contains("status 400") == true)
    }
    
    func testSubmitLoadingState() async {
        viewModel = SignUpViewModel(service: mockService, animator: .none)
        viewModel.email = "test@example.com"
        viewModel.password = "password123"
        viewModel.name = "Test User"
        viewModel.step = .name
        
        mockService.mockDelay = 0.1
        
        let loadingBegan = expectation(description: "Loading began")
        let loadingEnded = expectation(description: "Loading ended")
        
        viewModel.$isLoading
            .dropFirst()        // ignora o valor inicial (false)
            .sink { isLoading in
                if isLoading { loadingBegan.fulfill() }
                else { loadingEnded.fulfill() }
            }
            .store(in: &cancellables)
        
        Task { _ = await viewModel.submit() }
        
        await fulfillment(of: [loadingBegan, loadingEnded], timeout: 2.0)
    }
    
    // MARK: - Error Mapping Tests
    
    func testErrorMapping() async {
        // Given
        viewModel.email = "test@example.com"
        viewModel.password = "password123"
        viewModel.name = "Test User"
        viewModel.step = .name
        
        // Test different error types
        let testCases: [(SignUpError, String)] = [
            (.invalidStatus(400), "status 400"),
            (.invalidStatus(500), "status 500"),
            (.decoding, "interpretar a resposta"),
            (.transport(NSError(domain: "Test", code: 1)), "Falha de rede")
        ]
        
        for (error, expectedMessage) in testCases {
            // When
            mockService.mockError = error
            let result = await viewModel.submit()
            
            // Then
            XCTAssertNil(result)
            XCTAssertNotNil(viewModel.errorMessage)
            XCTAssertTrue(viewModel.errorMessage?.contains(expectedMessage) == true)
        }
    }
    
    // MARK: - Mock User Tests
    
    func testSubmitMockUser() {
        // Given & When
        let mockUser = viewModel.submitMockUser()
        
        // Then
        XCTAssertEqual(mockUser.id, "1234")
        XCTAssertEqual(mockUser.email, "1@1.com")
        XCTAssertEqual(mockUser.name, "Zé Maria")
    }
    
    // MARK: - Performance Tests
    @MainActor
    func testEmailValidationPerformance() {
        let testEmails = [
            "valid@example.com",
            "invalid.email",
            "test@domain.co.uk",
            "user+tag@example.org",
            "not-an-email"
        ]
        
        measure {
            for email in testEmails {
                viewModel.email = email
                _ = viewModel.isContinueEnabled
            }
        }
    }
    
    func testSubmitPerformance() {
        // prep no MainActor
        let prep = expectation(description: "prep")
        var vm: SignUpViewModel!
        Task { @MainActor in
            vm = self.viewModel
            vm.email = "test@example.com"
            vm.password = "password123"
            vm.name = "Test User"
            vm.step = .name
            self.mockService.mockUser = User(id: "123", email: vm.email, name: vm.name)
            self.mockService.mockDelay = 0
            prep.fulfill()
        }
        wait(for: [prep], timeout: 1.0)
        
        // warm-up (opcional)
        let warm = expectation(description: "warm")
        Task { @MainActor in
            _ = await vm.submit()
            warm.fulfill()
        }
        wait(for: [warm], timeout: 1.0)
        
        measureMetrics([.wallClockTime], automaticallyStartMeasuring: false) {
            let exp = expectation(description: "submit-perf")
            Task { @MainActor in
                self.startMeasuring()
                _ = await vm.submit()
                self.stopMeasuring()
                exp.fulfill()
            }
            wait(for: [exp], timeout: 1.0)
        }
    }
}

// MARK: - Mock SignUpService

private class MockSignUpService: SignUpServicing {
    var mockUser: User?
    var mockError: Error?
    var mockDelay: TimeInterval = 0
    
    func register(_ request: SignUpRequest) async throws -> User {
        if let delay = mockDelay > 0 ? mockDelay : nil {
            try await Task.sleep(nanoseconds: UInt64(delay * 1_000_000_000))
        }
        
        if let error = mockError {
            throw error
        }
        
        guard let user = mockUser else {
            throw SignUpError.invalidStatus(500)
        }
        
        return user
    }
}
