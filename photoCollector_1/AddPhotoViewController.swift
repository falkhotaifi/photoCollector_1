//
//  AddPhotoViewController.swift
//  photoCollector_1
//
//  Created by Faisal Alkhotaifi on 4/4/17.
//  Copyright © 2017 Faisal Alkhotaifi. All rights reserved.
//

import UIKit

class AddPhotoViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @IBOutlet weak var imageViewField: UIImageView!
    @IBOutlet weak var TextField: UITextField!
    
    var imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        imagePicker.delegate = self
        
    }
    
    @IBAction func PhotoButton(_ sender: Any) {
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        imageViewField.image = image
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func CameraButton(_ sender: Any) {
    }
    
    @IBAction func AddButton(_ sender: Any) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let photo = Photo(context: context)
        photo.title = TextField.text
        photo.image = UIImagePNGRepresentation(imageViewField.image!)! as NSData
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        navigationController!.popViewController(animated: true)
    }
    
    
}
