//
//  OnboardingView.swift
//  pokedexSwiftUI
//
//  Created by Vinicius Cabral on 13/09/25.
//

import SwiftUI

struct OnboardingView: View {
    @ObservedObject var presenter: OnboardingPresenter
    @EnvironmentObject var nav: AppNavigator

    private let dotWidth: CGFloat = 9
    private let dotHeight: CGFloat = 9
    private let dotSpacing: CGFloat = 25
    private let sliderWidth: CGFloat = 23
    private let duration: TimeInterval = 0.25
    private let defaultPadding: CGFloat = 16

    var body: some View {
        VStack(spacing: 0) {
            Spacer().frame(height: 175)

                TabView(selection: Binding(
                    get: { presenter.state.currentStep },
                    set: { presenter.send(.stepChanged($0)) })
                ) {
                    ForEach(presenter.state.steps.enumerated(), id: \.offset) { index, step in
                        VStack(spacing: dotSpacing) {
                            if index == 0 {
                                MakeTrainingImage(firstImage: ImageKey.maleCoachOne.rawValue,
                                                  secondImage: ImageKey.maleCoachTwo.rawValue)
                            } else if index == 1 {
                                MakeTrainingImage(firstImage: ImageKey.femaleCoachOne.rawValue)
                            }
                            TitleDescriptionView(title: step.titleKey, description: step.descriptionKey)
                                .padding(.bottom, 20)
                        }
                        .tag(index)
                    }
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))

                ZStack(alignment: .bottom) {
                    HStack(spacing: dotSpacing) {
                        ForEach(presenter.state.steps.indices, id: \.self) { index in
                            Capsule()
                                .fill(index == presenter.state.currentStep ? ColorsNames.darkBlue : .gray)
                                .frame(width: index == presenter.state.currentStep ? dotSpacing : dotWidth,
                                       height: dotHeight)
                                .animation(.easeInOut(duration: duration),
                                           value: presenter.state.currentStep)
                        }
                    }
                    .padding(.bottom, defaultPadding)

                    if presenter.state.steps.count > 1 {
                        Capsule()
                            .fill(ColorsNames.darkBlue)
                            .frame(width: sliderWidth, height: dotHeight)
                            .offset(x: sliderX)
                            .allowsHitTesting(false)
                            .animation(.easeInOut(duration: duration),
                                       value: presenter.state.currentStep)
                            .padding(.bottom, defaultPadding)
                    }
                }

                VStack {
                    Spacer().frame(height: defaultPadding)
                    Button(action: { presenter.primaryTapped() }) {
                        Rectangle()
                            .frame(height: 58)
                            .clipShape(.capsule)
                            .foregroundStyle(ColorsNames.darkBlue)
                            .overlay {
                                Text("Continuar")
                                    .foregroundStyle(.white)
                                    .font(FontMaker.makeFont(.poppinsSemiBold, 18))
                            }
                    }
                    .padding(.horizontal, defaultPadding)
                }
                .frame(maxWidth: .infinity, alignment: .bottom)

        }
        .padding(.horizontal, defaultPadding)
        .onAppear { presenter.send(.onAppear) }
        .navigationBarBackButtonHidden(true)
    }

    private var sliderX: CGFloat {
        let idx = CGFloat(presenter.state.currentStep)
        let step = (dotWidth + dotSpacing)
        return idx * step
    }
}

#Preview {
    let nav = AppNavigator()
    
    let factory = OnboardingFactoryLive(nav: nav)
    
    return factory.makeScene()
        .environmentObject(nav)
}
