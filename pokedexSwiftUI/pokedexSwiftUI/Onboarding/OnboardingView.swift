//
//  OnboardingView.swift
//  pokedexSwiftUI
//
//  Created by Vinicius Cabral on 13/09/25.
//

import SwiftUI

struct OnboardingView: View {
    @ObservedObject var viewModel: OnboardingViewModel
    @State var offset: CGFloat = 0
    private let dotWidth: CGFloat = 9
    private let dotHeight: CGFloat = 9
    private let dotSpacing: CGFloat = 25
    
    var body: some View {
        Spacer().frame(height: 175)
        VStack{
            TabView(selection: $viewModel.currentStep) {
                ForEach(0..<viewModel.onboardingSteps.count, id: \.self) { index in
                    VStack {
                        if index == 0 {
                            trainersImages()
                                .overlay(
                                    GeometryReader{proxy -> Color in
                                        let minX = proxy.frame(in: .global).minX
                                        DispatchQueue.main.async{
                                            withAnimation(.default){
                                                self.offset = -minX
                                            }
                                        }
                                        return Color.clear
                                    }
                                )
                        } else if index == 1 {
                            trainersStepTwo()
                        }
                        
                        let step = viewModel.onboardingSteps[index]
                        makeView(title: step.title, description: step.description)
                    }
                }
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            .overlay(
                HStack(spacing: dotSpacing) {
                    ForEach(viewModel.onboardingSteps.indices, id: \.self) { index in
                        Capsule()
                            .fill(dotColor(at: index))
                            .frame(width: getIndex() == index ? 25 : dotWidth, height: dotHeight)
                    }
                }
                    .overlay(
                        Capsule()
                            .fill(Color("DarkBlue"))
                            .frame(width: 23, height: dotHeight)
                            .offset(x: sliderX())
                            .animation(.easeInOut(duration: 0.25), value: getIndex())
                    )
                    .padding(.bottom, 10), alignment: .bottom
            )
            
            VStack{
                Spacer().frame(height: 45)
                continueButton
                    .padding(.horizontal, 16)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
    }
    
    func getIndex() -> Int {
        let raw = Int(round(offset / getWidth()))
        return min(max(raw, 0), viewModel.onboardingSteps.count - 1)
    }
    
    func sliderX() -> CGFloat {
        let progress = max(0, min(offset / getWidth(), CGFloat(viewModel.onboardingSteps.count - 1)))
        return progress * (dotWidth + dotSpacing)
    }
    
    func dotColor(at index: Int) -> Color {
        index == getIndex() ? Color("DarkBlue") : .gray
    }
}

// MARK: - continueButton
var continueButton: some View {
    Button(action: {
        
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

// MARK: - OnboardingView Methods
extension OnboardingView{
    func trainersStepTwo() -> some View {
        ZStack{
            Image("treinadora1")
                .offset(x: 10)
                .background{
                    Image("sombra")
                        .offset(x: 5, y: 115)
                }
        }
    }
    
    func trainersImages() -> some View {
        ZStack{
            Image("treinador1")
                .offset(x: -50)
                .background{
                    Image("sombra")
                        .offset(x: -65, y: 110)
                }
            
            Image("treinador2")
                .offset(x: 50, y: -10)
                .background{
                    Image("sombra")
                        .offset(x: 50, y: 115)
                }
        }
    }
    
    func makeView(title: String, description: String) -> some View {
        var titleAndDescription: some View {
            VStack(spacing: 16){
                Text(title)
                    .font(Font.custom("Poppins-Medium", size: 26))
                    .multilineTextAlignment(.center)
                    .foregroundStyle(Color("AppPrimary"))
                
                Text(description)
                    .font(Font.custom("Poppins-Regular", size: 14))
                    .multilineTextAlignment(.center)
                    .foregroundStyle(Color("AppSecondary"))
            }
            .padding(.horizontal, 16)
        }
        
        return titleAndDescription
    }
}

extension View{
    func getWidth() -> CGFloat {
        return UIScreen.main.bounds.width
    }
}

#Preview {
    OnboardingView(viewModel: OnboardingViewModel())
}
