//
//  AddBookViewController.swift
//  ProlificLibraryApp
//
//  Created by Bereket Ghebremedhin on 3/10/17.
//  Copyright © 2017 Bereket Ghebremedhin. All rights reserved.
//

import UIKit

class AddBookViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var bookTitleTextField: UITextField!
    @IBOutlet weak var bookAuthorTextField: UITextField!
    @IBOutlet weak var bookPublisherTextField: UITextField!
    @IBOutlet weak var bookCategoriesTextField: UITextField!
    @IBOutlet weak var submitBookButton: UIButton!
    @IBOutlet weak var cancelBookButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Add a Book"
       
    }

    @IBAction func submitBookButtonTapped(_ sender: Any) {
        guard let title = self.bookTitleTextField.text else {
            self.postAlertResponse(message: "Invalid Input")
            return
        }
        guard let author = self.bookAuthorTextField.text else {
            self.postAlertResponse(message: "Invalid Input")
            return
        }
        guard let publisher = self.bookPublisherTextField.text else {
            self.postAlertResponse(message: "Invalid Input")
            return
        }
        guard let categories = self.bookTitleTextField.text else {
            self.postAlertResponse(message: "Invalid Input")
            return
        }
        let postDict = ["title":title, "author":author, "publisher":publisher, "categories":categories]
        let params = postDict as [String: Any]
        self.postData(params: params)
    }

    func postData(params: [String:Any]){
        let request = ProlificRequest(type: .post(parameters: params))
        ViewModel.startUpdating(request: request){ results in
            switch results{
            case .success():
                self.postAlertResponse(message: "Post Sent")
            case .failure(let error):
                print("could not complete due to \(error.localizedDescription)")
                self.postAlertResponse(message: "Invalid Input")

            }

        }
    }

    func postAlertResponse(message:String){
        let alert = UIAlertController(title: message, message: "\(message)", preferredStyle: .alert)
        let ok = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alert.addAction(ok)
        self.present(alert, animated: true, completion: nil)
    }



    @IBAction func cancelButtonTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
