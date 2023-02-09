//
//  ActivityCardView.swift
//  Consent
//
//  Created by Lusine Magauzyan on 01.02.23.
//

import SwiftUI

struct ActivityCardView: View {
    @EnvironmentObject private var store: AppStore
    var activity: Activity
    
    
    @State private var offset = CGSize.zero
    
    var body: some View {
        
        GeometryReader { proxy in
            let size = proxy.size
            let index = CGFloat(store.state.index(activity: activity))
            let topOffset = (index <= 2 ? index : 2) * 15
            
            ZStack(alignment: .top) {
                Rectangle()
                    .frame(width: size.width - topOffset, height: size.height)
                    .cornerRadius(16)
                    .foregroundColor(Color(.systemCyan))
                    .offset(y: -topOffset)
                    .shadow(radius: 8)
                
                HStack {
                    StickerTextView(text: "CONSENT", degrees: -20, color: Color(.systemMint), offset: offset, multiplier: 1)
                    Spacer()
                    StickerTextView(text: "NOPE", degrees: 20, color: Color(.systemPink), offset: offset, multiplier: -1)
                }
                .padding()
                .padding(.top, 40)
                
                VStack {
                    Spacer()
                    HStack {
                        Text(activity.name)
                            .font(.largeTitle)
                            .foregroundColor(.white)
                            .bold()
                    }
                    .padding()
                }
            }
        }
        .contentShape(Rectangle())
        .offset(x: offset.width, y: offset.height * 0.4)
        .rotationEffect(.degrees(Double(offset.width / 40)))
        .gesture(
            DragGesture()
                .onChanged({ gesture in
                    offset = gesture.translation
                })
                .onEnded({ gesture in
                    
                    let width = UIScreen.main.bounds.width - 50
                    let translation = gesture.translation.width
                    let newTranslation = translation > 0 ? translation : -translation
                    withAnimation {
                        if newTranslation > width / 2 {
                            offset = CGSize(width:(translation > 0 ? width : -width) * 2, height: 0)
                            
                            if translation > 0 {
                                rightSwipe()
                            } else {
                                leftSwipe()
                            }
                        } else {
                            offset = .zero
                        }
                    }
                })
        )
    }
    
    private func endSwipeAction() {
//        store.state.exploreActivities.removeFirst()
    }
    
    private func leftSwipe() {
//        exploreData.swipe(activity: activity, right: false)
        endSwipeAction()
    }
    
    private func rightSwipe() {
//        exploreData.swipe(activity: activity, right: true)
        endSwipeAction()
    }
}

struct ActivityCardView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


