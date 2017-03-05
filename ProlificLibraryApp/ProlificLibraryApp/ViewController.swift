//
//  ViewController.swift
//  ProlificLibraryApp
//
//  Created by Bereket Ghebremedhin on 3/4/17.
//  Copyright © 2017 Bereket Ghebremedhin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        ViewModel.startNetworking()
        let array = URLRequestBuilder.bookModelArray
        print("\(array)")
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

