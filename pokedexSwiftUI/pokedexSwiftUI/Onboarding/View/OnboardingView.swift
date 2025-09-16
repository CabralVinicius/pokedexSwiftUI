//
//  OnboardingView.swift
//  pokedexSwiftUI
//
//  Created by Vinicius Cabral on 13/09/25.
//

import SwiftUI

struct OnboardingView: View {
    @ObservedObject var viewModel: OnboardingViewModel
    @State var isFirstText:Bool = true
    
    var body: some View {
        Spacer().frame(height: 175)
        VStack{
            TabView(selection: $viewModel.currentStep) {
                ForEach(0..<viewModel.onboardingSteps.count, id: \.self) { index in
                    VStack {
                        if index == 0 {
                            trainersImages()
                        } else if index == 1 {
                            trainersStepTwo()
                        }
                        
                        let step = viewModel.onboardingSteps[index]
                        makeView(title: step.title, description: step.description)
                    }
                }
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            
            VStack{
                onboardingProgressView
                Spacer().frame(height: 45)
                continueButton
                    .padding(.horizontal, 16)
            }
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
        
    }
}


// MARK: - onboardingProgressView
var onboardingProgressView: some View {
    HStack{
        Rectangle()
            .frame(width: 28, height: 9)
            .clipShape(.capsule)
            .foregroundStyle(Color("DarkBlue"))
        Circle()
            .frame(width: 9, height: 9)
            .foregroundStyle(Color(.lightGray))
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

#Preview {
    OnboardingView(viewModel: OnboardingViewModel())
}
