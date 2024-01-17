//
//  ProgressSlider.swift
//  ITunesSearch
//
//  Created by Dong on 2024/1/17.
//

import SwiftUI

struct ProgressSlider: View {
    
    @Binding var value: Double
    @State var lastCoordinateValue: CGFloat = 0.0
    
    var sliderRange: ClosedRange<Double> = 0...100
    
    var body: some View {
        GeometryReader { geometry in
            let width = geometry.size.width
            let height = geometry.size.height
            
            let minValue = 0.0 + height
            let maxValue = width - height
            let radius = height * 0.5
            
            let lower = sliderRange.lowerBound
            let scale = (maxValue - minValue) / (sliderRange.upperBound - sliderRange.lowerBound)
            let sliderValue = (self.value - lower) * scale + minValue
            
            ZStack {
                RoundedRectangle(cornerRadius: radius)
                    .foregroundStyle(.gray)
                
                HStack {
                    RoundedRectangle(cornerRadius: radius)
                        .foregroundStyle(.white.opacity(0.8))
                        .frame(width: sliderValue + minValue)
                        .gesture(
                            DragGesture()
                                .onChanged { value in
                                    let width = value.translation.width
                                    var nextCoordinateValue = 0.0
                                    
                                    print()
                                    print("width: \(width)")
                                    print()
                                    
                                    if width > 0 {
                                        nextCoordinateValue = min(maxValue, lastCoordinateValue + width)
                                    } else {
                                        nextCoordinateValue = max(minValue, lastCoordinateValue + width)
                                    }
                                    
                                    self.value = ((nextCoordinateValue - minValue) / scale) + lower
                                }
                                .onEnded { _ in
                                    lastCoordinateValue = sliderValue
                                }
                        )
                    Spacer()
                        .frame(minWidth: 0)
                }
            }
            .frame(maxWidth: width)
        }
        
    }
}
