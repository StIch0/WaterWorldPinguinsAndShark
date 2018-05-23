//
//  StartViewController.swift
//  WaterWorldPinguinsAndShark
//
//  Created by Pavel Burdukovskii on 17/05/2018.
//  Copyright © 2018 Pavel Burdukovskii. All rights reserved.
//

import Foundation
import UIKit
class StartViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    let cellId  : String = "cellId"
    var viewModel : StartViewModel!
    var activityIndicator : UIActivityIndicatorView!
    var restartButton : UIButton! =  {
        var button = UIButton()
        button.setTitle("Resart", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(restartView), for: .touchDown)
        button.backgroundColor = .gray
        return button
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        if #available(iOS 9.0, *) {
            setUpView()
        } else {
            if #available(iOS 10.0, *) {
                setUpView()
            } else {
            }
        }
        collectionView?.register(StartViewControllerCell.self, forCellWithReuseIdentifier: cellId)
        viewModel = StartViewModel(animalsManager: AnimalsManager())
        activityIndicator.startAnimating()
        viewModel.updateData {
            self.collectionView?.reloadData()
            self.activityIndicator.stopAnimating()
        }
        tapOnScreen()
    }

    func tapOnScreen (){
        let tap = UITapGestureRecognizer(target: self, action: #selector(chooseDirectionAndMakeStep))
        tap.numberOfTouchesRequired = 1
        view.addGestureRecognizer(tap)
    }
    //action tap
    @objc func chooseDirectionAndMakeStep (){
        activityIndicator.startAnimating()
//        DispatchQueue.main.async{
            self.viewModel.runStep()
            self.collectionView?.reloadData()
            self.activityIndicator.stopAnimating()
//        }
    }
    //set up collectionView and restartButton in current view
    @available(iOS 9.0, *)
    func setUpView (){
        activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        activityIndicator.hidesWhenStopped = true
        view?.addSubview(restartButton)
        view?.addSubview(activityIndicator)
        restartButton.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        collectionView?.backgroundColor = .white
        collectionView?.isPagingEnabled = true
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            restartButton.bottomAnchor.constraint(equalTo: (view?.bottomAnchor)!),
            restartButton.leadingAnchor.constraint(equalTo: (view?.leadingAnchor)!),
            restartButton.trailingAnchor.constraint(equalTo: (view?.trailingAnchor)!),
            restartButton.heightAnchor.constraint(equalToConstant: 50),
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
            ])

    }
    // action restart button
    @objc func restartView(){
        viewModel.updateData {
            self.collectionView?.reloadData()
        }
        print("Resart")
    }
}
