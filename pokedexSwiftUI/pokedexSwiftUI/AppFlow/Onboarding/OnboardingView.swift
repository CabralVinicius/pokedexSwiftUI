//
//  OnboardingView.swift
//  pokedexSwiftUI
//
//  Created by Vinicius Cabral on 13/09/25.
//

import SwiftUI

struct OnboardingView: View {
    @ObservedObject var viewModel: OnboardingViewModel
    private let dotWidth: CGFloat = 9
    private let dotHeight: CGFloat = 9
    private let dotSpacing: CGFloat = 25
    private let sliderWidth: CGFloat = 23
    private let duration: TimeInterval = 0.25
    
    var body: some View {
        VStack(spacing: 0) {
            Spacer().frame(height: 175)
            TabView(selection: $viewModel.currentStep) {
                ForEach(viewModel.onboardingSteps.indices, id: \.self) { index in
                    VStack(spacing: dotSpacing) {
                        if index == 0 {
                            MakeTraningImage(firstImage: ImageKey.maleCoachOne.rawValue, secondImage: ImageKey.maleCoachTwo.rawValue)
                        } else if index == 1 {
                            MakeTraningImage(firstImage: ImageKey.femaleCoachOne.rawValue)
                        }
                        
                        let step = viewModel.onboardingSteps[index]
                        TitleDescriptionView(title: step.title, description: step.description)
                    }
                    .tag(index)
                }
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            
            ZStack(alignment: .bottom) {
                HStack(spacing: dotSpacing) {
                    ForEach(viewModel.onboardingSteps.indices, id: \.self) { index in
                        Capsule()
                            .fill(index == viewModel.currentStep ? Color("DarkBlue") : .gray)
                            .frame(width: index == viewModel.currentStep ? dotSpacing : dotWidth,
                                   height: dotHeight)
                            .animation(.easeInOut(duration: duration), value: viewModel.currentStep)
                    }
                }
                .padding(.bottom, 10)
                
                if viewModel.onboardingSteps.count > 1 {
                    Capsule()
                        .fill(Color("DarkBlue"))
                        .frame(width: sliderWidth, height: dotHeight)
                        .offset(x: sliderX)
                        .padding(.bottom, 10)
                        .allowsHitTesting(false)
                        .animation(.easeInOut(duration: duration), value: viewModel.currentStep)
                }
            }
            
            VStack {
                Spacer().frame(height: 45)
                continueButton
                    .padding(.horizontal, 16)
            }
            .frame(maxWidth: .infinity, alignment: .bottom)
        }
        .padding(.horizontal, 16)
        .onAppear {
            if viewModel.onboardingSteps.isEmpty {
                viewModel.currentStep = 0
            } else {
                viewModel.currentStep = min(viewModel.currentStep, viewModel.onboardingSteps.count - 1)
            }
        }
    }
    
    private var sliderX: CGFloat {
        let idx = CGFloat(viewModel.currentStep)
        let step = (dotWidth + dotSpacing)
        return idx * step
    }
}

// MARK: - continueButton
private var continueButton: some View {
    Button(action: {
        // ação (pular para próxima tela, etc.)
    }, label: {
        Rectangle()
            .frame(height: 58)
            .clipShape(.capsule)
            .foregroundStyle(Color("DarkBlue"))
            .overlay {
                Text("Continuar")
                    .foregroundStyle(.white)
                    .font(Font.custom("Poppins-SemiBold", size: 18))
            }
    })
}

#Preview {
    OnboardingView(viewModel: OnboardingViewModel())
}
