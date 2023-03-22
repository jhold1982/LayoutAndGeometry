//
//  ContentView.swift
//  LayoutAndGeometry
//
//  Created by Justin Hold on 11/21/22.
//

import SwiftUI

// parent proposes a size for the child, the child uses that to determine its own size,
// and parent uses that to position the child appropriately

// MARK: EXTENSION & STRUCT FOR VERTICAL ALIGNMENT
extension VerticalAlignment {
	struct MidAccountAndName: AlignmentID {
		static func defaultValue(in context: ViewDimensions) -> CGFloat {
			context[.top]
		}
	}
	static let midAccountAndName = VerticalAlignment(MidAccountAndName.self)
}

// MARK: BORDERED CAPTION STRUCT, INITIALIZER, & METHOD
// Example to save for later projects
struct BorderedCaption: ViewModifier {
	private var backgroundColor: Color
	private var foregroundColor: Color
	
	init(backgroundColor: Color = Color.green, foregroundColor: Color = Color.white) {
		self.backgroundColor = backgroundColor
		self.foregroundColor = foregroundColor
	}
	
	func body(content: Content) -> some View {
		content.padding(5)
			.foregroundColor(foregroundColor)
			.clipShape(RoundedRectangle(cornerRadius: 10.0, style: .continuous))
			.background {
				backgroundColor
			}
			.clipShape(RoundedRectangle(cornerRadius: 10.0, style: .continuous))
	}
}

struct OuterView: View {
	var body: some View {
		VStack {
			Text("Top")
			InnerView()
				.background(.green)
			Text("Bottom")
		}
	}
}
struct InnerView: View {
	var body: some View {
		HStack {
			Text("Left")
			
			GeometryReader { geo in
				Text("Center")
					.background(.blue)
					.onTapGesture {
						print("Global Center: \(geo.frame(in: .global).midX) x \(geo.frame(in: .global).midY)")
						print("Local Center: \(geo.frame(in: .local).midX) x \(geo.frame(in: .local).midY)")
						print("Custom Center: \(geo.frame(in: .named("Custom")).midX) x \(geo.frame(in: .named("Custom")).midY)")
					}
			}
			.background(.orange)
			
			Text("Right")
		}
	}
}

struct ContentView: View {
	
//	// MARK: COLORS ARRAY FOR: .background(colors[index % 7]) Text() modifier
//	let colors: [Color] = [.red, .orange, .yellow, .green, .blue, .purple, .pink]
	
    var body: some View {
		
//		// MARK: HORIZONTAL STACK CONTAINING LEFT & RIGHT VERTICAL STACKS
//		HStack(alignment: .midAccountAndName) {
//
//			// MARK: VERTICAL STACK LEFT
//			VStack {
//				Text("@leftHandedApps")
//					.alignmentGuide(.midAccountAndName) { d in d[VerticalAlignment.center]}
//				Image("thirdeye")
//					.resizable()
//					.frame(width: 64, height: 64)
//			}
//
//			// MARK: VERTICAL STACK RIGHT
//			VStack {
//				Text("Full name:")
//				Text("Justin  🇺🇸")
//					.alignmentGuide(.midAccountAndName) { d in d[VerticalAlignment.center]}
//					.font(.largeTitle)
//			}
//		}
		
		// MARK: GEOMETRY READER OUTER, SCROLLVIEW, GEOMETRY READER INNER
		GeometryReader { fullView in
			ScrollView(.vertical) {
				ForEach(0..<50) { index in
					GeometryReader { geo in
						Text("Row #\(index)")
							.font(.title)
							.fontWeight(.semibold)
							.frame(maxWidth: .infinity)
							.background(Color(hue: min(1,geo.frame(in: .global).minY / fullView.size.height), saturation: 1, brightness: 1))
							.rotation3DEffect(.degrees(geo.frame(in: .global).minY - fullView.size.height / 2) / 5, axis: (x: 0, y: 1, z: 0))
							.opacity(geo.frame(in: .global).minY / 200)
							.scaleEffect(max(0.5, geo.frame(in: .global).minY / 400))
					}
					.frame(height: 40)
				}
			}
		}
		
//		// MARK: SCROLLVIEW FOR OLD ITUNES ALBUM ART FLOW
//		ScrollView(.horizontal, showsIndicators: false) {
//			HStack(spacing: 0) {
//				ForEach(1..<20) { num in
//					GeometryReader { geo in
//						Text("Number \(num)")
//							.font(.largeTitle)
//							.padding()
//							.background(.red)
//							.rotation3DEffect(.degrees(-geo.frame(in: .global).minX) / 8, axis: (x: 0, y: 1, z: 0))
//							.frame(width: 200, height: 200)
//					}
//					.frame(width: 200, height: 200)
//				}
//			}
//		}
		
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
