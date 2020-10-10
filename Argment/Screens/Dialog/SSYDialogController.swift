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
    
    private var actions: [SSYDialogAction] = []
    private var actionsConstraints: [NSLayoutConstraint] = []
    
    let dialogContainer: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 8
        view.accessibilityIdentifier = "dialogContainer"
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var animationView: AnimationView  = {
        let view = AnimationView(name: "")
        view.translatesAutoresizingMaskIntoConstraints = false
        view.animationSpeed = 0.8
        view.backgroundColor = .legendary
        view.loopMode = .loop
        return view
    }()
    
    let titlelabel : UILabel = {
        let view = UILabel()
        view.font = .boldSystemFont(ofSize: 24)
        view.textAlignment = .center
        view.textColor = .black
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let textLabel : UITextView = {
        let view = UITextView()
        view.isUserInteractionEnabled = false
        view.textColor = .black
        view.backgroundColor = .none
        view.font = .systemFont(ofSize: 14)
        view.textAlignment = .center
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
//    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?)   {
//        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
//        modalPresentationStyle = .overCurrentContext
//        dialogContainer.clipsToBounds = true
//    }
    
    init(title: String, message: String?, animation: String) {
        super.init(nibName: nil, bundle: nil)
        modalPresentationStyle = .overCurrentContext
        animationView.animation = Animation.named(animation)
        dialogContainer.clipsToBounds = true
        titlelabel.text = title
        textLabel.text = message
    }
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .dialogBackground
        setupActions()
        setupTaps()
        layoutViews()
    }
    
    func addAction(_ action: SSYDialogAction) {
        if (actions.count > 2) {
            fatalError("You cannot add more than 2 actions for this type of dialog!")
        }
        actions.append(action)
    }
    
    func setupActions() {
        actions.sort{ $1 > $0 }
        for action in actions {
            action.button.onTapped { [weak self] _ in
                self?.dismiss(animated: true)
                action.action?()
            }
        }
        
        if !actions.isEmpty {
            if actions.count == 1 {
                actionsConstraints = [
                    actions[0].button.heightAnchor.constraint(equalToConstant: 48),
                    actions[0].button.leftAnchor.constraint(equalTo: dialogContainer.leftAnchor, constant: 8),
                    actions[0].button.rightAnchor.constraint(equalTo: dialogContainer.rightAnchor, constant: -8),
                    actions[0].button.bottomAnchor.constraint(equalTo: dialogContainer.bottomAnchor, constant: -12)
                ]
            }
            if actions.count == 2{
                    actionsConstraints = [
                    actions[0].button.heightAnchor.constraint(equalToConstant: 48),
                    actions[0].button.leftAnchor.constraint(equalTo: dialogContainer.leftAnchor, constant: 16),
                    actions[0].button.rightAnchor.constraint(equalTo: dialogContainer.centerXAnchor, constant: -8),
                    actions[0].button.bottomAnchor.constraint(equalTo: dialogContainer.bottomAnchor, constant: -16),
                    
                    actions[1].button.heightAnchor.constraint(equalToConstant: 48),
                    actions[1].button.leftAnchor.constraint(equalTo: dialogContainer.centerXAnchor, constant: 8),
                    actions[1].button.rightAnchor.constraint(equalTo: dialogContainer.rightAnchor, constant: -16),
                    actions[1].button.bottomAnchor.constraint(equalTo: dialogContainer.bottomAnchor, constant: -16)
                ]
            }
        }
    }
    
    func layoutViews() {
        view.addSubview(dialogContainer)
        for subView in actions.map({ $0.button }) + [ animationView, titlelabel, textLabel] {
            dialogContainer.addSubview(subView)
        }
        
        NSLayoutConstraint.activate([
            dialogContainer.topAnchor.constraint(equalTo: view.topAnchor, constant: 40),
            dialogContainer.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            dialogContainer.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            dialogContainer.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -120),

            animationView.leftAnchor.constraint(equalTo: dialogContainer.leftAnchor),
            animationView.topAnchor.constraint(equalTo: dialogContainer.topAnchor),
            animationView.rightAnchor.constraint(equalTo: dialogContainer.rightAnchor),
            animationView.bottomAnchor.constraint(equalTo: dialogContainer.topAnchor, constant: 240),
            
            titlelabel.heightAnchor.constraint(equalToConstant: 22),
            titlelabel.topAnchor.constraint(equalTo: animationView.bottomAnchor, constant: 12),
            titlelabel.leftAnchor.constraint(equalTo: dialogContainer.leftAnchor, constant: 12),
            titlelabel.rightAnchor.constraint(equalTo: dialogContainer.rightAnchor, constant: -12),
            
            textLabel.topAnchor.constraint(equalTo: titlelabel.bottomAnchor, constant: 12),
            textLabel.leftAnchor.constraint(equalTo: dialogContainer.leftAnchor, constant: 12),
            textLabel.rightAnchor.constraint(equalTo: dialogContainer.rightAnchor, constant: -12),
            textLabel.bottomAnchor.constraint(equalTo: dialogContainer.bottomAnchor, constant: -12),
        ] + actionsConstraints)
        
        animationView.play()
    }
        
    func setupTaps(){
        view.onTapped { [weak self] _ in
            self?.dismiss(animated: true)
        }
        
        dialogContainer.onTapped { _ in }
    }
}

struct SSYDialogAction : Comparable {
    let action: (() -> Void)?
    let title: String
    let style: SSYActionStyle
    let button: UIButton
    init(title: String, style: SSYActionStyle = .basic, action: (() -> Void)? = nil) {
        self.action = action
        self.title = title
        self.style = style
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 24
        button.accessibilityIdentifier = title
        button.backgroundColor = style.color
        button.titleLabel?.font = style.font
        button.setTitle(title, for: .normal)
        self.button = button
    }
    
    static func < (lhs: SSYDialogAction, rhs: SSYDialogAction) -> Bool {
        return lhs.style.rawValue < rhs.style.rawValue
    }
    
    static func == (lhs: SSYDialogAction, rhs: SSYDialogAction) -> Bool {
        return lhs.style.rawValue == rhs.style.rawValue && lhs.title == rhs.title
    }
}

enum SSYActionStyle: Int {
    case destructive = 1
    case basic = 2
    
    var color: UIColor {
        switch self {
        case .destructive:
            return .secondary
        case .basic:
            return .common
        }
    }
    
    var font: UIFont {
        switch self {
        case .destructive:
            return .boldSystemFont(ofSize: 16)
        case .basic:
            return .boldSystemFont(ofSize: 16)
        }
    }
}
