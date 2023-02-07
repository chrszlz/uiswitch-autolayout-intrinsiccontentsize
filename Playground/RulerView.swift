//
//  RulerView.swift
//  Playground
//
//  Created by chris on 2/7/23.
//

import UIKit
import SnapKit

class RulerView: UIView {
    
    enum Edge {
        case left
        case right
    }
    
    private var edge: Edge = .right
    
    private lazy var ruler = UIView()

    private lazy var label: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 10)
        label.textColor = .white
        return label
    }()
    
    init(edge: Edge, width: Double = 51, height: Double = 16, border: Bool = false) {
        super.init(frame: CGRect(x: 0, y: 0, width: width, height: height))
        self.edge = edge
        self.configure(width: width, height: height, border: border)
    }
    
    required init?(coder: NSCoder) {
        fatalError("Nothin here")
    }
    
    private func configure(width: Double, height: Double, border: Bool) {
        setContentHuggingPriority(.defaultLow, for: .horizontal)
        setContentCompressionResistancePriority(.required, for: .horizontal)
        
        label.text = "\(Int(width)) px"
        
        ruler.addSubview(label)
        label.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        ruler.backgroundColor = .red
        addSubview(ruler)
        ruler.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.width.equalTo(width)
            make.height.equalTo(height)
            
            switch edge {
            case .left:
                make.left.equalToSuperview()
            case .right:
                make.right.equalToSuperview()
            }
        }
        
        if (border) {
            layer.borderColor = UIColor.red.cgColor
            layer.borderWidth = 1
        }
    }
    
}
