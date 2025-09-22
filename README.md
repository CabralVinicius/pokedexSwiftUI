# 📱 PokedexSwiftUI

## 🇧🇷 Sobre o Projeto
O **PokedexSwiftUI** é um aplicativo iOS desenvolvido em **SwiftUI**, utilizando a arquitetura **MVVM** combinada com **Router** e **Coordinator** para gerenciar fluxos de navegação de forma desacoplada e escalável.  
O objetivo é demonstrar boas práticas de desenvolvimento iOS, incluindo:
- Separação clara de responsabilidades
- Consumo de API (PokéAPI)
- Gerenciamento de estado reativo
- Componentização de UI
- Testes unitários e de interface

Embora seja baseado no conceito clássico de uma Pokédex, o foco está em mostrar **qualidade de código, arquitetura robusta e escalabilidade**.

---

## 🇺🇸 About the Project
**PokedexSwiftUI** is an iOS application built with **SwiftUI**, following the **MVVM** architecture pattern combined with **Router** and **Coordinator** to manage navigation flows in a decoupled and scalable way.  
The goal is to showcase iOS development best practices, including:
- Clear separation of concerns
- API consumption (PokéAPI)
- Reactive state management
- UI componentization
- Unit and UI testing

While based on the classic Pokédex concept, the main focus is to demonstrate **code quality, robust architecture, and scalability**.

---

## 🏗 Arquitetura / Architecture

**🇧🇷**  
O projeto segue o padrão **MVVM (Model–View–ViewModel)**, garantindo separação clara de responsabilidades e facilitando manutenção e testes.  
A navegação é gerenciada por um **Router** central, enquanto **Coordinators** controlam fluxos específicos da aplicação, permitindo escalabilidade e desacoplamento entre módulos.  

Essa abordagem possibilita:  
- Evolução do código sem impacto em outras camadas  
- Testabilidade dos ViewModels isoladamente  
- Navegação flexível e reutilizável  

**🇺🇸**  
The project follows the **MVVM (Model–View–ViewModel)** pattern, ensuring a clear separation of concerns and making maintenance and testing easier.  
Navigation is handled by a central **Router**, while **Coordinators** manage specific application flows, enabling scalability and decoupling between modules.  

This approach allows:  
- Code evolution without impacting other layers  
- Isolated ViewModel testability  
- Flexible and reusable navigation

---

## 🛠 Tecnologias / Technologies

**🇧🇷**  
- **Swift 5+**  
- **SwiftUI**  
- **Combine**  
- **async/await**  
- **MVVM + Router + Coordinator**  
- **URLSession** para chamadas de API  
- **XCTest** para testes  

**🇺🇸**  
- **Swift 5+**  
- **SwiftUI**  
- **Combine**  
- **async/await**  
- **MVVM + Router + Coordinator**  
- **URLSession** for API calls  
- **XCTest** for testing  

---

