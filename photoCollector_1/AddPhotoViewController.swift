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
    @IBOutlet weak var AddUpdate: UIButton!
    @IBOutlet weak var deletebutton: UIButton!
    
    var imagePicker = UIImagePickerController()
    
    var photo : Photo? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        imagePicker.delegate = self
        
        if photo != nil {
            imageViewField.image = UIImage(data: photo!.image! as Data)
            TextField.text = photo!.title
            AddUpdate.setTitle("Update", for: .normal)
        } else {
            deletebutton.isHidden = true
        }
        
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
        imagePicker.sourceType = .camera
        present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func AddButton(_ sender: Any) {
        
        if photo != nil {
            photo!.title = TextField.text
            photo!.image = UIImagePNGRepresentation(imageViewField.image!)! as NSData
        }else {
            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            let photo = Photo(context: context)
            photo.title = TextField.text
            photo.image = UIImagePNGRepresentation(imageViewField.image!)! as NSData
        }
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        navigationController!.popViewController(animated: true)
    }
    
    @IBAction func DeleteButton(_ sender: Any) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        context.delete(photo!)
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        navigationController!.popViewController(animated: true)
    }
    
}
