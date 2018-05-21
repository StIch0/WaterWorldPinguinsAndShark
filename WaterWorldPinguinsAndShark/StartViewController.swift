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
    var tap : Bool = false
    let cellId  : String = "cellId"
    var viewModel : StartViewModel!
    var activityIndicator : UIActivityIndicatorView!
    var restartButton : UIButton! =  {
        var button = UIButton()
        button.setTitle("Resart", for: .normal)
        button.addTarget(self, action: #selector(restartView), for: .touchDown)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .white
        return button
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
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
    @objc func chooseDirectionAndMakeStep (){
        tap = true
        self.viewModel.runStep()
        self.collectionView?.reloadData()
        print("Tap")
    }
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
        print(collectionView?.frame.height, view?.frame.height)

    }
    @objc func restartView(){
        viewModel.updateData {
            self.collectionView?.reloadData()
        }
        print("Resart")
    }
}
