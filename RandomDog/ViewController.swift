//  ViewController.swift
//  RandomDog
//
//  Created by Mustafa Eftekin on 9.08.2022.
//

import UIKit

public extension UIView {
    func showAnimation(_ completionBlock: @escaping () -> Void) {
        isUserInteractionEnabled = false
        UIView.animate(withDuration: 0.1,
                       delay: 0,
                       options: .curveLinear,
                       animations: { [weak self] in
                            self?.transform = CGAffineTransform.init(scaleX: 0.95, y: 0.95)
        }) {  (done) in
            UIView.animate(withDuration: 0.1,
                           delay: 0,
                           options: .curveLinear,
                           animations: { [weak self] in
                                self?.transform = CGAffineTransform.init(scaleX: 1, y: 1)
            }) { [weak self] (_) in
                self?.isUserInteractionEnabled = true
                completionBlock()
            }
        }
    }
}

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
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .medium)
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.2
        button.layer.shadowOffset = CGSize(width: 4, height: 4)
        button.layer.shadowRadius = 5.0
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 25
        return button
    }()
    
    let colors: [UIColor] = [
        .systemPink,
        .systemBlue,
        .systemGreen,
        .systemYellow,
        .systemPurple,
        .systemOrange,
        .systemCyan
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemPink
        view.addSubview(imageView)
        imageView.frame = CGRect(x: 0, y: 0, width: 300, height: 400)
        imageView.center = view.center
        imageView.layer.shadowColor = UIColor.black.cgColor
        imageView.layer.shadowOpacity = 0.2
        imageView.layer.shadowOffset = CGSize(width: 4, height: 4)
        imageView.layer.shadowRadius = 5.0
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 7
        view.addSubview(button)
        getDogPhoto { _ in }
        button.addTarget(self, action: #selector(buttonTapped(sender:)), for: .touchUpInside)
    }

    
    @objc func buttonTapped(sender: UIButton) {
        getDogPhoto { [weak self] success in
            if success {
                DispatchQueue.main.async {
                    self?.view.backgroundColor = self?.colors.randomElement()
                    sender.showAnimation {}
                }
            }
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        button.frame = CGRect(x: 30, y: view.frame.size.height-100-view.safeAreaInsets.bottom, width: view.frame.size.width-60, height: 55)
    }
    
    func getDogPhoto(completion: @escaping (Bool) -> Void) {
        let urlString = "https://dog.ceo/api/breeds/image/random"
        let url = URL(string: urlString)!
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let data = data, error == nil else {
                completion(false)
                return
            }
            
            do {
                if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                   let imageUrlString = json["message"] as? String,
                   let imageUrl = URL(string: imageUrlString),
                   let imageData = try? Data(contentsOf: imageUrl) {
                    
                    DispatchQueue.main.async {
                        self?.imageView.image = UIImage(data: imageData)
                        completion(true)
                    }
                } else {
                    completion(false)
                }
            } catch {
                completion(false)
            }
        }
        
        task.resume()
    }


}

       
