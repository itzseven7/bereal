//
//  StoryCarouselView.swift
//  BeRealTechnicalTest
//
//  Created by Romain Dubreucq on 26/04/2025.
//

import Foundation
import SwiftUI

struct StoryCarouselView: View {
    @ObservedObject private var viewModel: StoryCarouselViewModel
    @GestureState private var dragOffset: CGSize = .zero
    
    init(viewModel: StoryCarouselViewModel) {
        self._viewModel = .init(wrappedValue: viewModel)
    }

    var body: some View {
        VStack {
            ZStack(alignment: .topTrailing) {
                if !viewModel.stories.isEmpty {
                    image(forStory: viewModel.stories[viewModel.currentIndex])
                        .resizable()
                        .scaledToFit()
                        .gesture(
                            DragGesture()
                                .updating($dragOffset) { value, state, _ in
                                    state = value.translation
                                }
                                .onEnded { value in
                                    if value.translation.width < -100 {
                                        viewModel.nextStory()
                                    } else if value.translation.width > 100 {
                                        viewModel.previousStory()
                                    }
                                }
                        )
                        .onAppear {
                            viewModel.markViewed(index: viewModel.currentIndex)
                        }
                    pageControl()
                    .padding()
                }
            }
            likeButton()
            .padding()
        }
        .animation(.easeInOut, value: viewModel.currentIndex)
        .task {
            await viewModel.load()
        }
    }
    
    // MARK: - Page control
    
    private func pageControl() -> some View {
        HStack {
            ForEach(viewModel.stories.indices, id: \.self) { index in
                pageControlItem(isSeen: viewModel.stories[index].isSeen)
            }
        }
    }
    
    private func pageControlItem(isSeen: Bool) -> some View {
        Circle()
             .fill(isSeen ? Color.green : Color.gray)
         .frame(width: 8, height: 8)
    }
    
    // MARK: - Like button
    
    @ViewBuilder
    private func likeButton() -> some View {
        if viewModel.stories.isEmpty == false {
            Button(action: {
                viewModel.likeCurrentStory()
            }) {
                Text(viewModel.stories[viewModel.currentIndex].isLiked ? "Unlike" : "Like")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
        } else {
            EmptyView()
        }
    }
    
    private func image(forStory story: Story) -> Image {
        guard let image = UIImage(data: viewModel.imageData(for: story)) else {
            return Image(systemName: "xmark")
        }
        
        return Image(uiImage: image)
    }
}
