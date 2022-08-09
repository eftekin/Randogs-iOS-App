//
//  ViewController.swift
//  RandomDog
//
//  Created by Mustafa Eftekin on 9.08.2022.
//

import UIKit

class ViewController: UIViewController {
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .white
        return imageView
    }()

    private let button: UIButton = {
        let button = UIButton()
        button.backgroundColor = .white
        button.setTitle("Get Dog", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.2
        button.layer.shadowOffset = CGSize(width: 4, height: 4)
        button.layer.shadowRadius = 5.0
        button.layer.masksToBounds = false
        return button
    }()
    
    let colors: [UIColor] = [
        .systemPink,
        .systemBlue,
        .systemGreen,
        .systemYellow,
        .systemPurple,
        .systemOrange
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemPink
        view.addSubview(imageView)
        imageView.frame = CGRect(x: 0, y: 0, width: 300, height: 300)
        imageView.center = view.center
        imageView.layer.shadowColor = UIColor.black.cgColor
        imageView.layer.shadowOpacity = 0.2
        imageView.layer.shadowOffset = CGSize(width: 4, height: 4)
        imageView.layer.shadowRadius = 5.0
        imageView.layer.masksToBounds = false
        view.addSubview(button)
        getDogPhoto()
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)

    }
    
    @objc func didTapButton() {
        getDogPhoto()
        
        view.backgroundColor = colors.randomElement()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        button.frame = CGRect(x: 30, y: view.frame.size.height-150-view.safeAreaInsets.bottom, width: view.frame.size.width-60, height: 55)
    }
    
    func getDogPhoto() {
        let urlString = "https://source.unsplash.com/random/600x600/?dog"
        let url = URL(string: urlString)!
        guard let data = try? Data(contentsOf: url) else {
            return
        }
        imageView.image = UIImage(data: data)
    }

}

