//
//  FilterView.swift
//  Presentation
//
//  Created by 김동락 on 2023/08/02.
//  Copyright © 2023 com.lito. All rights reserved.
//

import SwiftUI

// 필터링 버튼 + 필터 박스 나열
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
        VStack {
            ScrollView(.horizontal) {
                VStack {
                    HStack {
                        filteringButton
                        filteredBoxes
                    }
                }
                .padding(.leading)
            }.scrollIndicators(.never)
        }
    }
    
    // 필터링 버튼
    @ViewBuilder
    private var filteringButton: some View {
        Button {
            filterSheetToggle()
        } label: {
            HStack(spacing: 8) {
                Image(systemName: SymbolName.line3Decrese)
                    .font(.system(size: 16, weight: .regular))
                    .foregroundColor(.Text_Default)
                Text("필터")
                    .font(.system(size: 14, weight: .regular))
                    .foregroundColor(.Text_Default)
            }
            .padding(.horizontal, 15)
            .padding(.vertical, 8)
        }
        .background(
            RoundedRectangle(cornerRadius: 19 )
                .fill(.Bg_Default)
        )
        .overlay(
            RoundedRectangle(cornerRadius: 19 )
                .stroke(.Border_Light, lineWidth: 1)
        )
        .sheet(isPresented: $showFilterSheet) {
            filteringModal
                .presentationDetents([.medium])
                .presentationDragIndicator(.visible)
                .presentationCornerRadius(30)
                .frame(alignment: .topTrailing)
                .padding(.top, 40)
                .padding(.leading, 20)
        }
    }
    
    // 동적으로 선택된 필터 박스들
    @ViewBuilder
    private var filteredBoxes: some View {
        ForEach(selectedFilters, id: \.self) { filter in
            if filter != T.defaultValue {
                Button {
                    removeFilter(filter)
                } label: {
                    HStack(spacing: 8) {
                        Text(filter.name)
                            .font(.system(size: 14, weight: .regular))
                            .foregroundColor(.Text_White)
                        Image(systemName: SymbolName.xmarkCircleFill)
                            .font(.system(size: 16, weight: .regular))
                            .foregroundStyle(.white, .Button_Point_Light)
                    }
                    .padding(.horizontal, 15)
                    .padding(.vertical, 8)
                }
                .background(
                    RoundedRectangle(cornerRadius: 19 )
                        .fill(.Button_Point)
                )
            }
        }
    }
    
    // 필터링 요소
    @ViewBuilder
    private var filteringComponents: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("풀이 여부")
                .font(.title2)
            HStack {
                ForEach(T.allCases, id: \.self) { filter in
                    Button {
                        selectFilter(filter)
                    } label: {
                        Text(filter.name)
                            .font(.system(size: 14, weight: .regular))
                            .foregroundColor(selectedFilter == filter ? .Text_White : .Text_Default)
                    }
                    .background(
                        RoundedRectangle(cornerRadius: 19 )
                            .fill(selectedFilter == filter ? .Button_Point : .Bg_Light)
                    )
//                    Button(filter.name) {
//                        selectFilter(filter)
//                    }
//                    .buttonStyle(.borderedProminent)
//                    .tint(selectedFilter == filter ? .orange : .gray)
                }
            }
        }
    }

    // 필터링 모달
    @ViewBuilder
    private var filteringModal: some View {
        VStack(alignment: .leading) {
            filteringComponents
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
        .onAppear {
            storePrevFilter()
        }
        .onDisappear {
            cancelSelectedFilter()
        }
    }
}

extension FilterView {
    // 필터 모달 보여주기 or 끄기
    private func filterSheetToggle() {
        showFilterSheet.toggle()
    }
    
    // 선택된 필터 해제하기
    private func removeFilter(_ filter: T) {
        if let index = selectedFilters.firstIndex(of: filter) {
            selectedFilters.remove(at: index)
            selectedFilter = T.defaultValue
        }
        filterHandling.updateProblem()
    }
    
    // 필터 선택하기
    private func selectFilter(_ filter: T) {
        if selectedFilter == filter {
            selectedFilter = T.defaultValue
        } else {
            selectedFilter = filter
        }
    }
    
    // 필터 적용하기
    private func applyFilter() {
        isApply = true
        showFilterSheet = false
        if selectedFilter != prevFilter {
            selectedFilters = [selectedFilter]
            filterHandling.updateProblem()
        }
    }

    // 취소할 경우를 대비해서 원래 필터 저장해놓기
    private func storePrevFilter() {
        prevFilter = selectedFilter
    }
    
    // 적용 안하고 그냥 닫아버리면 원래꺼로 되돌려놓기
    private func cancelSelectedFilter() {
        if !isApply {
            selectedFilter = prevFilter
        } else {
            isApply = false
        }
    }
}
