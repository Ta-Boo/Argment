//
//  SSYDialogController.swift
//  Argment
//
//  Created by hladek on 02/08/2020.
//  Copyright © 2020 hladek. All rights reserved.
//

import Foundation
import UIKit
import Lottie


class SSYDialogController: UIViewController {
    
    let dialogContainer: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 8
        view.accessibilityIdentifier = "dialogContainer"
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let cancelButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 32
        button.accessibilityIdentifier = "cancelButton"
        button.backgroundColor = .secondary
        button.titleLabel?.font = .boldSystemFont(ofSize: 16)
        button.setTitle("Cancel", for: .normal)

        return button
    }()
    
    let submitButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 32
        button.accessibilityIdentifier = "submitButton"
        button.backgroundColor = .common
        button.setTitle("Yes", for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 16)
        return button
    }()
    
    let animationView: AnimationView = {
        let view = AnimationView(name: "chest_opening")
        view.translatesAutoresizingMaskIntoConstraints = false
        view.animationSpeed = 0.8
        view.backgroundColor = .legendary
        view.loopMode = .loop
        return view
    }()
    
    let titleView : UILabel = {
        
    }()
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?)   {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        modalPresentationStyle = .overCurrentContext
        dialogContainer.clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .dialogBackground
        layoutViews()
        setUpTaps()
    }
    
    func layoutViews() {
        view.addSubview(dialogContainer)
        for subView in [cancelButton, submitButton, animationView] {
            dialogContainer.addSubview(subView)
        }
        
        NSLayoutConstraint.activate([
            dialogContainer.topAnchor.constraint(equalTo: view.topAnchor, constant: 40),
            dialogContainer.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            dialogContainer.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            dialogContainer.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -120),
            
            cancelButton.heightAnchor.constraint(equalToConstant: 64),
            cancelButton.leftAnchor.constraint(equalTo: dialogContainer.leftAnchor, constant: 16),
            cancelButton.rightAnchor.constraint(equalTo: dialogContainer.centerXAnchor, constant: -8),
            cancelButton.bottomAnchor.constraint(equalTo: dialogContainer.bottomAnchor, constant: -16),
            
            submitButton.heightAnchor.constraint(equalToConstant: 64),
            submitButton.leftAnchor.constraint(equalTo: dialogContainer.centerXAnchor, constant: 8),
            submitButton.rightAnchor.constraint(equalTo: dialogContainer.rightAnchor, constant: -16),
            submitButton.bottomAnchor.constraint(equalTo: dialogContainer.bottomAnchor, constant: -16),

            animationView.leftAnchor.constraint(equalTo: dialogContainer.leftAnchor),
            animationView.topAnchor.constraint(equalTo: dialogContainer.topAnchor),
            animationView.rightAnchor.constraint(equalTo: dialogContainer.rightAnchor),
            animationView.bottomAnchor.constraint(equalTo: dialogContainer.topAnchor, constant: 240)
        ])
        
        animationView.play()
    }
        
    func setUpTaps(){
        view.onTapped { [weak self] _ in
            self?.dismiss(animated: true)
        }
        
        dialogContainer.onTapped { _ in }
        
        cancelButton.onTapped { [weak self] _ in
            self?.dismiss(animated: true)
        }
        
    }
}
