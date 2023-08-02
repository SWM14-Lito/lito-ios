//
//  FilterView.swift
//  Presentation
//
//  Created by 김동락 on 2023/08/02.
//  Copyright © 2023 com.lito. All rights reserved.
//

import SwiftUI

protocol FilterComponent: CaseIterable, Hashable {
    associatedtype T

    var name: String { get }
    static var allCases: [Self] { get }
    static var defaultValue: Self { get }
}

protocol FilterHandling {
    func resetProblemCellList()
    func getProblemList()
}

struct FilterView<T: FilterComponent>: View {
    
    @State private var selectedFilter: T = .defaultValue
    @State private var prevFilter: T = .defaultValue
    @State private var isApply: Bool = false
    @State private var showFilterSheet: Bool = false
    @Binding var selectedFilters: [T]
    private let filterHandling: FilterHandling
    
    init(selectedFilters: Binding<[T]>, filterHandling: FilterHandling) {
        self._selectedFilters = selectedFilters
        self.filterHandling = filterHandling
    }
    
    var body: some View {
        filteringView
    }
    
    @ViewBuilder
    private var filteringView: some View {
        ScrollView(.horizontal) {
            VStack {
                HStack {
                    Button {
                        filterSheetToggle()
                    } label: {
                        HStack {
                            Text("필터")
                            Image(systemName: SymbolName.arrowtriangleDown)
                        }
                    }
                    .padding(.horizontal)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10   )
                            .stroke(Color.gray, lineWidth: 1)
                    )
                    .sheet(isPresented: $showFilterSheet) {
                        filteringModal
                            .presentationDetents([.medium])
                            .presentationDragIndicator(.visible)
                            .frame(alignment: .topTrailing)
                    }
                    // 동적으로 선택된 필터 박스 생성.
                    ForEach(selectedFilters, id: \.self) { filter in
                        if filter != T.defaultValue {
                            Button(filter.name) {
                                removeFilter(filter)
                            }
                            .font(.caption)
                            .buttonStyle(.borderedProminent)
                            .tint(.orange)
                        }
                    }
                }
            }
            .padding(.leading)
        }.scrollIndicators(.never)
    }

    @ViewBuilder
    private var filteringModal: some View {
        
        VStack(alignment: .leading) {
            VStack(alignment: .leading, spacing: 20) {
                Text("풀이 여부")
                    .font(.title2)
                HStack {
                    ForEach(T.allCases, id: \.self) { filter in
                        Button(filter.name) {
                            selectFilter(filter)
                        }
                        .buttonStyle(.borderedProminent)
                        .tint(selectedFilter == filter ? .orange : .gray)
                    }
                }
            }
            Spacer()
            HStack(alignment: .center) {
                Spacer()
                Button("초기화") {
                    selectedFilter = T.defaultValue
                }
                .buttonStyle(.bordered)
                .font(.title2)
                Spacer()
                Button("적용하기") {
                    applyFilter()
                }
                .buttonStyle(.bordered)
                .font(.title2)
                Spacer()
            }
        }
        .padding(20)
        .onAppear {
            storePrevFilter()
        }
        .onDisappear {
            cancelSelectedFilter()
        }
    }
}

extension FilterView {
    private func filterSheetToggle() {
        showFilterSheet.toggle()
    }
    
    private func removeFilter(_ filter: T) {
        if let index = selectedFilters.firstIndex(of: filter) {
            selectedFilters.remove(at: index)
            selectedFilter = T.defaultValue
        }
        filterHandling.resetProblemCellList()
        filterHandling.getProblemList()
    }
    
    private func selectFilter(_ filter: T) {
        if selectedFilter == filter {
            selectedFilter = T.defaultValue
        } else {
            selectedFilter = filter
        }
    }
    
    private func applyFilter() {
        isApply = true
        showFilterSheet = false
        if selectedFilter != prevFilter {
            selectedFilters = [selectedFilter]
            filterHandling.resetProblemCellList()
            filterHandling.getProblemList()
        }
    }

    private func storePrevFilter() {
        prevFilter = selectedFilter
    }
    
    private func cancelSelectedFilter() {
        if !isApply {
            selectedFilter = prevFilter
        } else {
            isApply = false
        }
    }
}
