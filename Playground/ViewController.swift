//
//  ViewController.swift
//  Playground
//
//  Created by chris on 2/6/23.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.layer.borderColor = UIColor.red.cgColor
        scrollView.layer.borderWidth = 1
        scrollView.alwaysBounceVertical = true
        return scrollView
    }()
    
    private lazy var leftRuler = RulerView(edge: .left, border: true)
    private lazy var leftLongRuler = RulerView(edge: .left, width: 51 + 16, border: true)
    private lazy var leftSwitch = ToggleView(edge: .left, title: "Exercise Tracking")
    private lazy var rightRuler = RulerView(edge: .right, border: true)
    private lazy var rightSwitch = ToggleView(edge: .right, title: "Exercise Tracking")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // ScrollView
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
        
        // Left
        scrollView.addSubview(leftRuler)
        leftRuler.snp.makeConstraints { make in
            make.left.top.right.width.equalToSuperview()
        }
        
        scrollView.addSubview(leftSwitch)
        leftSwitch.snp.makeConstraints { make in
            make.top.equalTo(leftRuler.snp.bottom)
            make.left.right.equalToSuperview()
        }
        
        scrollView.addSubview(leftLongRuler)
        leftLongRuler.snp.makeConstraints { make in
            make.top.equalTo(leftSwitch.snp.bottom)
            make.left.right.equalToSuperview()
        }
        
        // Right
        scrollView.addSubview(rightRuler)
        rightRuler.snp.makeConstraints { make in
            make.top.equalTo(leftLongRuler.snp.bottom).offset(64)
            make.left.right.width.equalToSuperview()
        }
        
        scrollView.addSubview(rightSwitch)
        rightSwitch.snp.makeConstraints { make in
            make.top.equalTo(rightRuler.snp.bottom)
            make.left.right.equalToSuperview()
        }
    }
    
}

class Switch: UISwitch {
    
    override var intrinsicContentSize: CGSize {
        // super.intrinsicContentSize
        bounds.size
    }
    
}

class ToggleView: UIStackView {
    
    enum Edge {
        case left
        case right
    }
    
    private lazy var iconView: UIImageView = {
        let view = UIImageView()
        view.layer.borderColor = UIColor.red.cgColor
        view.layer.borderWidth = 1
        view.snp.makeConstraints { make in
            make.width.height.equalTo(24)
        }
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        let view = UILabel()
        view.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        view.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        return view
    }()
    
    private lazy var descLabel: UILabel = {
        let view = UILabel()
        view.numberOfLines = 0
        view.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        view.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        return view
    }()
    
    private lazy var titleContainer: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = 5
        view.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        view.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        return view
    }()
    
    private lazy var toggleSwitch: Switch = {
        let control = Switch()
        control.setContentCompressionResistancePriority(.required, for: .horizontal)
        control.setContentHuggingPriority(.required, for: .horizontal)
        control.isOn = true
        return control
    }()
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(edge: Edge, title: String, description: String? = nil) {
        super.init(frame: .zero)
        self.axis = .horizontal
        self.alignment = .center
        self.distribution = .fill
        self.spacing = 16
        
        titleLabel.text = title
        descLabel.text = description
        
        titleContainer.addArrangedSubview(titleLabel)
        if description != nil {
            titleContainer.addArrangedSubview(descLabel)
        }
        
        switch edge {
        case .left:
            self.addArrangedSubview(toggleSwitch)
            self.addArrangedSubview(iconView)
            self.addArrangedSubview(titleContainer)
        case .right:
            self.addArrangedSubview(iconView)
            self.addArrangedSubview(titleContainer)
            self.addArrangedSubview(toggleSwitch)
        }
        
        self.clipsToBounds = true
    }
    
}
