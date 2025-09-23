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
    private let defaultPadding: CGFloat = 16
    
    var body: some View {
        VStack(spacing: 0) {
            Spacer().frame(height: 175)
            TabView(selection: $viewModel.currentStep) {
                ForEach(viewModel.onboardingSteps.enumerated(), id: \.offset) { index, step in
                    VStack(spacing: dotSpacing) {
                        if index == 0 {
                            MakeTraningImage(firstImage: ImageKey.maleCoachOne.rawValue, secondImage: ImageKey.maleCoachTwo.rawValue)
                        } else if index == 1 {
                            MakeTraningImage(firstImage: ImageKey.femaleCoachOne.rawValue)
                        }
                        
                        TitleDescriptionView(title: step.title, description: step.description)
                            .padding(.bottom, 20)
                    }
                    .tag(index)
                }
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            
            ZStack(alignment: .bottom) {
                HStack(spacing: dotSpacing) {
                    ForEach(viewModel.onboardingSteps.indices, id: \.self) { index in
                        Capsule()
                            .fill(index == viewModel.currentStep ? ColorsNames.darkBlue : .gray)
                            .frame(width: index == viewModel.currentStep ? dotSpacing : dotWidth,
                                   height: dotHeight)
                            .animation(.easeInOut(duration: duration), value: viewModel.currentStep)
                    }
                }
                .padding(.bottom, defaultPadding)
                
                if viewModel.onboardingSteps.count > 1 {
                    Capsule()
                        .fill(ColorsNames.darkBlue)
                        .frame(width: sliderWidth, height: dotHeight)
                        .offset(x: sliderX)
                        .allowsHitTesting(false)
                        .animation(.easeInOut(duration: duration), value: viewModel.currentStep)
                        .padding(.bottom, defaultPadding)
                }
            }
            
            VStack {
                Spacer().frame(height: defaultPadding)
                continueButton
                    .padding(.horizontal, defaultPadding)
            }
            .frame(maxWidth: .infinity, alignment: .bottom)
        }
        .padding(.horizontal, defaultPadding)

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
            .foregroundStyle(ColorsNames.darkBlue)
            .overlay {
                Text("Continuar")
                    .foregroundStyle(.white)
                    .font(FontMaker.makeFont(.poppinsSemiBold, 18))
            }
    })
}

#Preview {
    OnboardingView(viewModel: OnboardingViewModel())
}
