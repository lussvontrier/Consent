//
//  ActivityCardView.swift
//  Consent
//
//  Created by Lusine Magauzyan on 01.02.23.
//

import SwiftUI

struct ActivityCardView: View {
    @EnvironmentObject var exploreData: ExploreViewModel
    var activity: Activity
    @State private var offset = CGSize.zero
    
    var body: some View {
        
        GeometryReader { proxy in
            let size = proxy.size
            let index = CGFloat(exploreData.index(activity: activity))
            let topOffset = (index <= 2 ? index : 2) * 15
            
            ZStack(alignment: .top) {
                Rectangle()
                    .frame(width: size.width - topOffset, height: size.height)
                    .cornerRadius(16)
                    .foregroundColor(activity.color)
                    .offset(y: -topOffset)
                    .shadow(radius: 8)
                
                HStack {
                    Text("NOPE")
                        .padding()
                        .font(.title)
                        .rotationEffect(.degrees(-20))
                        .foregroundColor(Color(.systemPink))
                        .overlay(
                                RoundedRectangle(cornerRadius: 16)
                                    .stroke(Color(.systemPink), lineWidth: 4)
                                    .rotationEffect(.degrees(-20))
                        )
                        .opacity(Double((offset.width/(UIScreen.main.bounds.width-300) * -1)))
                    Spacer()
                    Text("CONSENT")
                        .padding()
                        .font(.title)
                        .rotationEffect(.degrees(20))
                        .foregroundColor(Color(.systemMint))
                        .overlay(
                                RoundedRectangle(cornerRadius: 16)
                                    .stroke(Color(.systemMint), lineWidth: 4)
                                    .rotationEffect(.degrees(20))
                        )
                        .opacity(Double(offset.width/(UIScreen.main.bounds.width-300)))
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
        exploreData.displayableActivities?.removeFirst()
    }
    
    func leftSwipe() {
        print("left swiped")
        endSwipeAction()
    }
    
    func rightSwipe() {
        print("right swiped")
        endSwipeAction()
    }
}

struct ActivityCardView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
