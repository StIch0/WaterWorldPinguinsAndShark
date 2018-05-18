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
        viewModel.updateData {
            self.collectionView?.reloadData()
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
        viewModel.op()
        self.collectionView?.reloadData()
    
        print("Tap")
    }
    func setUpView (){
        view?.addSubview(restartButton)
        restartButton.translatesAutoresizingMaskIntoConstraints = false
        collectionView?.backgroundColor = .white
        collectionView?.isPagingEnabled = true
        restartButton.bottomAnchor.constraint(equalTo: (view?.bottomAnchor)!).isActive = true
        restartButton.leadingAnchor.constraint(equalTo: (view?.leadingAnchor)!).isActive = true
        restartButton.trailingAnchor.constraint(equalTo: (view?.trailingAnchor)!).isActive = true
        restartButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    @objc func restartView(){
        viewModel.updateData {
            self.collectionView?.reloadData()
        }
        print("Resart")
    }
}
