//
//  AddBookViewController.swift
//  ProlificLibraryApp
//
//  Created by Bereket Ghebremedhin on 3/10/17.
//  Copyright © 2017 Bereket Ghebremedhin. All rights reserved.
//

import UIKit

class AddBookViewController: UIViewController {

    @IBOutlet weak var bookTitleTextField: UITextField!
    @IBOutlet weak var bookAuthorTextField: UITextField!
    @IBOutlet weak var bookPublisherTextField: UITextField!
    @IBOutlet weak var bookCategoriesTextField: UITextField!
    @IBOutlet weak var submitBookButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        submitBookButton.layer.cornerRadius = 20.0
        title = "Add a Book"
        // Do any additional setup after loading the view.
    }
    @IBAction func submitBookButtonTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

    @IBOutlet weak var submitBookButtonTapped: UIButton!
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
