//
//  LoadingView.swift
//  MusicApp
//
//  Created by Enes İşler on 4.07.2023.
//


import UIKit

class LoadingView {
    var acrivityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    static let shared = LoadingView()
    var blurView: UIVisualEffectView = UIVisualEffectView()
    
    private init() {
        configure()
    }
    
    func configure() {
        blurView = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
        blurView.translatesAutoresizingMaskIntoConstraints = false
        blurView.frame = UIWindow(frame: UIScreen.main.bounds).frame
        acrivityIndicator.center = blurView.center
        acrivityIndicator.hidesWhenStopped = true
        acrivityIndicator.style = .large
        blurView.contentView.addSubview(acrivityIndicator)
    }
    
    func startLoading() {
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
            let window = windowScene.windows.first {
            window.addSubview(blurView)
            blurView.translatesAutoresizingMaskIntoConstraints = false
            acrivityIndicator.startAnimating()
        }
    }
    
    func hideLoading() {
        blurView.removeFromSuperview()
        acrivityIndicator.stopAnimating()
    }
}
