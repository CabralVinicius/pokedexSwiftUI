//
//  OnboardingViewModelTests.swift
//  pokedexSwiftUITests
//
//  Created by Test Suite on 27/09/25.
//

import XCTest
import Combine
@testable import pokedexSwiftUI

@MainActor
final class OnboardingViewModelTests: XCTestCase {

    private var viewModel: OnboardingViewModel!
    private var cancellables: Set<AnyCancellable>!

    // MARK: - Lifecycle

    override func setUp() {
        super.setUp()
        viewModel = OnboardingViewModel()
        cancellables = Set<AnyCancellable>()
    }

    override func tearDown() {
        cancellables = nil
        viewModel = nil
        super.tearDown()
    }

    // MARK: - Initialization Tests

    func testInitialState() {
        // usa a VM criada no setUp()
        XCTAssertEqual(viewModel.currentStep, 0)
        XCTAssertEqual(viewModel.onboardingSteps.count, 2)
        XCTAssertEqual(viewModel.onboardingSteps[0].titleKey, "onboarding.step1.title")
        XCTAssertEqual(viewModel.onboardingSteps[0].descriptionKey, "onboarding.step1.description")
        XCTAssertEqual(viewModel.onboardingSteps[1].titleKey, "onboarding.step2.title")
        XCTAssertEqual(viewModel.onboardingSteps[1].descriptionKey, "onboarding.step2.description")
    }

    func testInitWithCustomSteps() {
        XCTAssertEqual(viewModel.currentStep, 0)
        XCTAssertEqual(viewModel.onboardingSteps.count, 2)
        XCTAssertEqual(viewModel.onboardingSteps[0].titleKey, "onboarding.step1.title")
        XCTAssertEqual(viewModel.onboardingSteps[0].descriptionKey, "onboarding.step1.description")
    }

    // MARK: - Current Step Tests

    func testCurrentStepInitialValue() {
        // Usa a instância preparada no setUp()
        XCTAssertEqual(viewModel.currentStep, 0)
    }

    func testCurrentStepCanBeModified() {
        XCTAssertEqual(viewModel.currentStep, 0)
        viewModel.currentStep = 1
        XCTAssertEqual(viewModel.currentStep, 1)
    }

    func testCurrentStepCanBeSetToZero() {
        viewModel.currentStep = 1
        viewModel.currentStep = 0
        XCTAssertEqual(viewModel.currentStep, 0)
    }

    func testCurrentStepCanBeSetToLastIndex() {
        let lastIndex = viewModel.onboardingSteps.count - 1
        viewModel.currentStep = lastIndex
        XCTAssertEqual(viewModel.currentStep, lastIndex)
    }

    func testCurrentStepCanBeSetBeyondBounds() {
        let beyondBounds = viewModel.onboardingSteps.count + 1
        viewModel.currentStep = beyondBounds
        XCTAssertEqual(viewModel.currentStep, beyondBounds)
    }

    // MARK: - Onboarding Steps Tests

    func testOnboardingStepsCount() {
        XCTAssertEqual(viewModel.onboardingSteps.count, 2)
    }

    func testOnboardingStepsContent() {
        XCTAssertEqual(viewModel.onboardingSteps[0].titleKey, "onboarding.step1.title")
        XCTAssertEqual(viewModel.onboardingSteps[0].descriptionKey, "onboarding.step1.description")
        XCTAssertEqual(viewModel.onboardingSteps[1].titleKey, "onboarding.step2.title")
        XCTAssertEqual(viewModel.onboardingSteps[1].descriptionKey, "onboarding.step2.description")
    }

    func testOnboardingStepsCanBeModified() {
        let newSteps = [
            InfoTextKeys(titleKey: "custom.step1.title", descriptionKey: "custom.step1.description"),
            InfoTextKeys(titleKey: "custom.step2.title", descriptionKey: "custom.step2.description"),
            InfoTextKeys(titleKey: "custom.step3.title", descriptionKey: "custom.step3.description")
        ]
        viewModel.onboardingSteps = newSteps
        XCTAssertEqual(viewModel.onboardingSteps.count, 3)
        XCTAssertEqual(viewModel.onboardingSteps[0].titleKey, "custom.step1.title")
        XCTAssertEqual(viewModel.onboardingSteps[1].titleKey, "custom.step2.title")
        XCTAssertEqual(viewModel.onboardingSteps[2].titleKey, "custom.step3.title")
    }

    // MARK: - Published Properties Tests

    func testCurrentStepIsPublished() {
        let exp = expectation(description: "Current step published")
        var receivedValue: Int?

        viewModel.$currentStep
            .dropFirst()
            .sink { value in
                receivedValue = value
                exp.fulfill()
            }
            .store(in: &cancellables)

        viewModel.currentStep = 1

        waitForExpectations(timeout: 1.0)
        XCTAssertEqual(receivedValue, 1)
    }

    func testOnboardingStepsIsPublished() {
        let exp = expectation(description: "Onboarding steps published")
        var receivedValue: [InfoTextKeys]?

        viewModel.$onboardingSteps
            .dropFirst()
            .sink { value in
                receivedValue = value
                exp.fulfill()
            }
            .store(in: &cancellables)

        viewModel.onboardingSteps = [
            InfoTextKeys(titleKey: "new.title", descriptionKey: "new.description")
        ]

        waitForExpectations(timeout: 1.0)
        XCTAssertEqual(receivedValue?.count, 1)
        XCTAssertEqual(receivedValue?.first?.titleKey, "new.title")
    }

    // MARK: - Integration Tests

    func testCurrentStepWithOnboardingSteps() {
        let customSteps = [
            InfoTextKeys(titleKey: "step1.title", descriptionKey: "step1.description"),
            InfoTextKeys(titleKey: "step2.title", descriptionKey: "step2.description"),
            InfoTextKeys(titleKey: "step3.title", descriptionKey: "step3.description")
        ]
        viewModel.onboardingSteps = customSteps

        for i in 0..<customSteps.count {
            viewModel.currentStep = i
            XCTAssertEqual(viewModel.currentStep, i)
        }
    }

    func testCurrentStepBoundsWithDynamicSteps() {
        let singleStep = [InfoTextKeys(titleKey: "single.title", descriptionKey: "single.description")]
        viewModel.onboardingSteps = singleStep
        viewModel.currentStep = 0

        XCTAssertEqual(viewModel.currentStep, 0)
        XCTAssertEqual(viewModel.onboardingSteps.count, 1)
    }

    // MARK: - Edge Cases Tests

    func testEmptyOnboardingSteps() {
        viewModel.onboardingSteps = []
        viewModel.currentStep = 0

        XCTAssertEqual(viewModel.currentStep, 0)
        XCTAssertEqual(viewModel.onboardingSteps.count, 0)
    }

    func testNegativeCurrentStep() {
        viewModel.currentStep = -1
        XCTAssertEqual(viewModel.currentStep, -1)
    }

    // MARK: - Performance Tests

    func testCurrentStepModificationPerformance() {
        // Blindagem caso steps sejam esvaziados em algum refactor futuro
        if viewModel.onboardingSteps.isEmpty {
            viewModel.onboardingSteps = [InfoTextKeys(titleKey: "a", descriptionKey: "b")]
        }
        measure {
            for i in 0..<1000 {
                viewModel.currentStep = i % viewModel.onboardingSteps.count
            }
        }
    }

    func testOnboardingStepsModificationPerformance() {
        let testSteps = (0..<100).map { index in
            InfoTextKeys(titleKey: "step\(index).title", descriptionKey: "step\(index).description")
        }
        measure {
            viewModel.onboardingSteps = testSteps
        }
    }
}
