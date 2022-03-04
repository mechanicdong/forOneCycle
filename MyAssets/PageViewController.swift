//
//  PageViewController.swift
//  MyAssets
//
//  Created by 이동희 on 2022/03/04.
//

import SwiftUI
import UIKit

struct PageViewController<Page: View>: UIViewControllerRepresentable {
    var pages: [Page]
    //@Binding을 이용하여 현재 어떤 페이지가 보여지는지 확인
    @Binding var currentPage: Int
    
    //UIViewControllerRepresentable 프로토콜 준수사항 1
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    //UIViewControllerRepresentable 프로토콜 준수사항 2
    func makeUIViewController(context: Context) -> some UIPageViewController {
        let pageViewController = UIPageViewController(
            transitionStyle: .scroll,
            navigationOrientation: .horizontal
        )
        pageViewController.dataSource = context.coordinator
        pageViewController.delegate = context.coordinator
        
        return pageViewController
    }
    
    //UIViewControllerRepresentable 프로토콜 준수사항 3
    func updateUIViewController(_ pageViewController: UIViewControllerType, context: Context) {
        pageViewController.setViewControllers(
            [context.coordinator.controller[currentPage]],
            direction: .forward,
            animated: true
        )
    }
    
    class Coordinator: NSObject, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
        var parent: PageViewController
        var controllers = [UIViewController]()
        
        //class는 init 필수
        init(_ pageViewController: PageViewController) {
            parent = pageViewController
            controllers = parent.pages.map { UIHostingController(rootView: $0) }
        }
        
        //ViewController before delegate
        func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
            guard let index = controllers.firstIndex(of: viewController) else { return nil }
            if index == 0 {
                return controllers.last
            }
            return controllers[index - 1]
        }
        //ViewController after delegate
        func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
            guard let index = controllers.firstIndex(of: viewController) else { return nil }
            if index + 1 == controllers.count {
                return controllers.first
            }
            return controllers[index + 1]
        }
    }
}

