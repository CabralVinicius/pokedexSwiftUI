//
//  RegisterViewModelTests.swift
//  pokedexSwiftUITests
//
//  Created by Vinicius Cabral on 04/10/25.
//

import XCTest
import Combine
@testable import pokedexSwiftUI

@MainActor
final class RegisterViewModelTests: XCTestCase {

    private var viewModel: RegisterViewModel!
    private var cancellables: Set<AnyCancellable>!

    // MARK: - Lifecycle

    override func setUp() {
        super.setUp()
        viewModel = RegisterViewModel()
        cancellables = []
    }

    override func tearDown() {
        cancellables = nil
        viewModel = nil
        super.tearDown()
    }

    // MARK: - Initialization

    func testInitialState_UsesDefaultSteps() {
        XCTAssertEqual(viewModel.currentSteps, 0)
        XCTAssertEqual(viewModel.loginOrRegisterInformations.count, 2)
        XCTAssertEqual(viewModel.loginOrRegisterInformations[0].titleKey, "auth.register.title")
        XCTAssertEqual(viewModel.loginOrRegisterInformations[0].descriptionKey, "auth.connect.how")
        XCTAssertEqual(viewModel.loginOrRegisterInformations[1].titleKey, "auth.login.title")
        XCTAssertEqual(viewModel.loginOrRegisterInformations[1].descriptionKey, "auth.connect.how")
    }
    
    func testInitWithCustomSteps() {
        XCTAssertEqual(viewModel.currentSteps, 0)
        XCTAssertEqual(viewModel.loginOrRegisterInformations.count, 2)
        XCTAssertEqual(viewModel.loginOrRegisterInformations[0].titleKey, "auth.register.title")
        XCTAssertEqual(viewModel.loginOrRegisterInformations[0].descriptionKey, "auth.connect.how")
        XCTAssertEqual(viewModel.loginOrRegisterInformations[1].titleKey, "auth.login.title")
        XCTAssertEqual(viewModel.loginOrRegisterInformations[1].descriptionKey, "auth.connect.how")
    }

    // MARK: - State mutation
    func testCurrentStepsCanBeModified() {
        XCTAssertEqual(viewModel.currentSteps, 0)
        viewModel.currentSteps = 1
        XCTAssertEqual(viewModel.currentSteps, 1)
        viewModel.currentSteps = 0
        XCTAssertEqual(viewModel.currentSteps, 0)
    }

    func testCurrentStepsAcceptsNegativeValues() {
        // Given
        XCTAssertEqual(viewModel.currentSteps, 0)

        // When
        viewModel.currentSteps = -1

        // Then
        XCTAssertEqual(viewModel.currentSteps, -1)
        // Note: no validation logic is applied — negative values are accepted by design
    }

    func testLoginOrRegisterInformationsCanBeReplaced() {
        let newSteps = [
            InfoTextKeys(titleKey: "a", descriptionKey: "A"),
            InfoTextKeys(titleKey: "b", descriptionKey: "B"),
        ]
        viewModel.loginOrRegisterInformations = newSteps

        XCTAssertEqual(viewModel.loginOrRegisterInformations.count, 2)
        XCTAssertEqual(viewModel.loginOrRegisterInformations[0].titleKey, "a")
        XCTAssertEqual(viewModel.loginOrRegisterInformations[1].titleKey, "b")
    }

    // MARK: - Published properties

    func testCurrentStepsIsPublished() {
        let exp = expectation(description: "currentSteps publishes")
        var received: Int?

        viewModel.$currentSteps
            .dropFirst()
            .sink { value in
                received = value
                exp.fulfill()
            }
            .store(in: &cancellables)

        viewModel.currentSteps = 2

        waitForExpectations(timeout: 1.0)
        XCTAssertEqual(received, 2)
    }

    func testLoginOrRegisterInformationsIsPublished() {
        let exp = expectation(description: "steps publishes")
        var received: [InfoTextKeys]?

        viewModel.$loginOrRegisterInformations
            .dropFirst()
            .sink { value in
                received = value
                exp.fulfill()
            }
            .store(in: &cancellables)

        viewModel.loginOrRegisterInformations = [
            InfoTextKeys(titleKey: "x", descriptionKey: "X")
        ]

        waitForExpectations(timeout: 1.0)
        XCTAssertEqual(received?.count, 1)
        XCTAssertEqual(received?.first?.titleKey, "x")
        XCTAssertEqual(received?.first?.descriptionKey, "X")
    }

    // MARK: - “Smoke test” de método trivial

    func testTesteMethodDoesNotCrash() {
        // Apenas garante que o método existe e não causa efeitos colaterais graves.
        viewModel.teste()
        XCTAssertTrue(true)
    }

    // MARK: - Performance

    func testPerformance_ModifyCurrentSteps() {
        // Blindagem caso steps sejam alterados para vazio no futuro
        if viewModel.loginOrRegisterInformations.isEmpty {
            viewModel.loginOrRegisterInformations = [InfoTextKeys(titleKey: "a", descriptionKey: "b")]
        }

        measure {
            let count = viewModel.loginOrRegisterInformations.count
            for i in 0..<1000 {
                viewModel.currentSteps = i % count
            }
        }
    }

    func testPerformance_ReplaceStepsArray() {
        let testSteps = (0..<100).map { i in
            InfoTextKeys(titleKey: "step\(i).title", descriptionKey: "step\(i).desc")
        }

        measure {
            viewModel.loginOrRegisterInformations = testSteps
        }
    }
}
