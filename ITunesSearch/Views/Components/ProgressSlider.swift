//
//  ProgressSlider.swift
//  ITunesSearch
//
//  Created by Dong on 2024/1/17.
//

import SwiftUI

struct ProgressSlider<V>: View where V : BinaryFloatingPoint, V.Stride : BinaryFloatingPoint {
    
    @Binding var value: V
    @State var lastCoordinateValue: CGFloat = 0.0
    
    var onEditingChanged: (V) -> Void = { _ in }
    var sliderRange: ClosedRange<V> = 0...1
    
    var body: some View {
        GeometryReader { geometry in
            let width = geometry.size.width
            let height = geometry.size.height
            
            let minValue = 0.0 + height
            let maxValue = width - height
            let radius = height * 0.5
            
            let lower = sliderRange.lowerBound
            let scale = (maxValue - minValue) / CGFloat((sliderRange.upperBound - sliderRange.lowerBound))
            let sliderValue = CGFloat((self.value - lower)) * scale + minValue
            
            ZStack {
                RoundedRectangle(cornerRadius: radius)
                    .foregroundStyle(.gray.opacity(0.2))
                
                HStack {
                    RoundedRectangle(cornerRadius: radius)
                        .foregroundStyle(.gray.opacity(0.6))
                        .frame(width: sliderValue + minValue)
                        .onAppear {
                            lastCoordinateValue = sliderValue
                        }
                        .gesture(
                            DragGesture()
                                .onChanged { value in
                                    let width = value.translation.width
                                    var nextCoordinateValue = 0.0
                                    
                                    if width > 0 {
                                        nextCoordinateValue = min(maxValue, lastCoordinateValue + width)
                                    } else {
                                        nextCoordinateValue = max(minValue, lastCoordinateValue + width)
                                    }
                                    
                                    self.value = V(((nextCoordinateValue - minValue) / scale)) + lower
                                }
                                .onEnded { _ in
                                    lastCoordinateValue = sliderValue
                                    onEditingChanged(value)
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
