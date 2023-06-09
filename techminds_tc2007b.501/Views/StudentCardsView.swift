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
        UserGrid<CardViewModel, CardView>(viewModels: [CardViewModel](viewModel.cardViewModels))
        .toolbar {
            ToolbarItemGroup(placement: .navigationBarTrailing) {
                NavigationLink {
                    InstructorCardsView()
                } label: {
                    Image(systemName: "pencil")
                        .resizable()
                    
                }
            }
        }
        .navigationTitle("Tarjetas")
        .onAppear {
            viewModel.getAllCards()
        }
    }
}

struct CardsView_Previews: PreviewProvider {
    static var previews: some View {
        StudentCardsView()
    }
}
