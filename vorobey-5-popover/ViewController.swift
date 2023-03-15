//
//  ViewController.swift
//  vorobey-5-popover
//
//  Created by Павел Бубликов on 14.03.2023.
//

import UIKit

class ViewController: UIViewController {
    
    private lazy var tapButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Present", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 24)
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    @objc func buttonTapped() {
        let popover = PopoverViewController()
        popover.preferredContentSize = CGSize(width: 300, height: 280)
        popover.modalPresentationStyle = .popover
        if let pres = popover.presentationController {
           pres.delegate = self
       }
        if let pop = popover.popoverPresentationController {
            pop.sourceView = tapButton
            pop.permittedArrowDirections = .up
            pop.sourceRect = tapButton.bounds
        }
        
        present(popover, animated: true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(tapButton)
        
        NSLayoutConstraint.activate([
            tapButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            tapButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            tapButton.widthAnchor.constraint(equalToConstant: 100),
            tapButton.heightAnchor.constraint(equalToConstant: 50),
        ])
        
        // Do any additional setup after loading the view.
    }


}

extension ViewController: UIPopoverPresentationControllerDelegate {
    public func adaptivePresentationStyle(for controller: UIPresentationController, traitCollection: UITraitCollection) -> UIModalPresentationStyle {
        return .none
    }
}

class PopoverViewController: UIViewController {
    
    private var segmentView: UISegmentedControl = {
        let segment = UISegmentedControl(items: ["280pt", "150pt"])
        segment.selectedSegmentIndex = 0
        segment.addTarget(self, action: #selector(changeSegment), for: .valueChanged)
        
        segment.translatesAutoresizingMaskIntoConstraints = false
        return segment
    }()
    
    private lazy var close: UIButton = {
        let close = UIButton()
        let image = UIImage(systemName: "xmark.circle.fill")?.applyingSymbolConfiguration(.init(scale: .large))
        
        close.setImage(image, for: .normal)
        close.scalesLargeContentImage = true
        close.backgroundColor = .clear
        
        close.translatesAutoresizingMaskIntoConstraints = false
        close.addTarget(self, action: #selector(closeControl), for: .touchUpInside)
        
        return close
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.frame = CGRect(x: 0, y: 0, width: 300, height: 280)
        view.backgroundColor = .white
        view.addSubview(segmentView)
        view.addSubview(close)
        
        NSLayoutConstraint.activate([
            segmentView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            segmentView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 20),
            
            close.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 15),
            close.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -5),
            close.widthAnchor.constraint(equalToConstant: 40),
            close.heightAnchor.constraint(equalToConstant: 40),
        ])
    }
    
    @objc func changeSegment() {
        print("change")
        if (segmentView.selectedSegmentIndex == 0) {
            preferredContentSize = CGSize(width: 300, height: 280)
            
        }
        
        if (segmentView.selectedSegmentIndex == 1) {
            preferredContentSize = CGSize(width: 300, height: 150)
        }
    }
    
    @objc func closeControl() {
        dismiss(animated: true)
    }
}

