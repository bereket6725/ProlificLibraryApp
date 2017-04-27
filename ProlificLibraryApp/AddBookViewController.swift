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

    var parentVC: BookListViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Add a Book"
    }
    
    //will check to make sure none of the fields are empty 
    @IBAction func submitBookButtonTapped(_ sender: Any) {
        guard let title = self.bookTitleTextField.text, !title.isEmpty else {
            self.postAlertResponse(message: "Invalid Input")
            return
        }
        guard let author = self.bookAuthorTextField.text, !author.isEmpty else {
            self.postAlertResponse(message: "Invalid Input")
            return
        }
        guard let publisher = self.bookPublisherTextField.text, !publisher.isEmpty else {
            self.postAlertResponse(message: "Invalid Input")
            return
        }
        guard let categories = self.bookTitleTextField.text, !categories.isEmpty else {
            self.postAlertResponse(message: "Invalid Input")
            return
        }
        let postDict = ["title":title, "author":author, "publisher":publisher, "categories":categories]
        let params = postDict as [String: Any]
        self.postData(params: params)
    }

    //adds a book to the library
    func postData(params: [String:Any]){
        let request = ProlificRequest(type: .post(parameters: params))
        ViewModel.startUpdating(request: request){ results in
            switch results{
            case .success():
                self.postAlertResponse(message: "Post Sent")
                self.parentVC.getBooks()
            case .failure(let error):
                print("could not complete due to \(error.localizedDescription)")
                self.postAlertResponse(message: "Invalid Input")
            }
        }
    }

    
    func postAlertResponse(message:String){
        let alert = UIAlertController(title: message, message: "\(message)", preferredStyle: .alert)
        //let ok = UIAlertAction(title: "Ok", style: .default, handler: nil)
        let ok = UIAlertAction(title: "Ok", style: .default) { _ in
            if message == "Post Sent"{
            self.dismissViewController()
            }
    }
        
        
        alert.addAction(ok)
        self.present(alert, animated: true, completion: nil)
    }
    
    func dismissViewController(){
        self.dismiss(animated: true, completion: nil)
    }


    @IBAction func cancelButtonTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
