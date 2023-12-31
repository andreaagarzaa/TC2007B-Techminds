//
//  CardsView.swift
//  techminds_tc2007b.501
//
//  Created by Alumno on 19/05/23.
//

import SwiftUI

struct StudentCardsView : View {
    @StateObject private var viewModel = CardListViewModel()
    
    var body: some View {
        UserDataGrid([CardViewModel](viewModel.cardViewModels).sorted(by: { v1, v2 in
            v1.card.name < v2.card.name
        }), emptyLabel: "No has creado ninguna tarjeta.") {
            CardView(viewModel: $0)
        }
        .onAppear {
            if viewModel.cardViewModels.isEmpty {
                print("cards loading")
                viewModel.getAll()
            }
        }
        .toolbar {
            ToolbarItemGroup(placement: .navigationBarTrailing) {
                NavigationLink {
                    Filter {
                        InstructorCardsView()
                    }
                } label: {
                    Image(systemName: "pencil")
                        .resizable()
                    
                }
            }
        }
        .navigationTitle("Tarjetas")
        
        
    }
}

struct CardsView_Previews: PreviewProvider {
    static var previews: some View {
        StudentCardsView()
    }
}
