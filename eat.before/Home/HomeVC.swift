//
//  ViewController.swift
//  eat.before
//
//  Created by Дарья Тимофеева on 30.03.2022.
//

import UIKit
import CoreData

protocol HomeVCDelegate: AnyObject {
    func recieved(food: Food)
}

class HomeVC: UIViewController {

    @IBOutlet weak var productNameTF: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var chooseDaysButton: UIButton!
    @IBOutlet weak var chooseDatePickerButton: UIButton!
    @IBOutlet weak var daysTF: UITextField!
    @IBOutlet weak var uploadedImage: UIImageView! {
        didSet {
            uploadedImage.isUserInteractionEnabled = true
        }
    }
    
    var viewModel = FoodListViewModel()
    var inputDate: Date = NSDate() as Date
    var productName: String?
    var enteredDays: Int?
    
    weak var delegate: HomeVCDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapImageView(_:)))
        uploadedImage.addGestureRecognizer(tapGestureRecognizer)
        productNameTF.delegate = self
        setButtonIcons()
    }
    
    @IBAction func chooseDays(_ sender: UIButton) {
        daysTF.isEnabled = true
        datePicker.isEnabled = false
        inputDate = countExpirationDate()
        
        chooseDatePickerButton.setImage(UIImage(systemName: "circle"), for: .normal)
        chooseDaysButton.setImage(UIImage(systemName: "checkmark.circle.fill"), for: .normal)
    }
    
    @IBAction func chooseDatePicker(_ sender: UIButton) {
        daysTF.isEnabled = false
        datePicker.isEnabled = true
        chooseDaysButton.setImage(UIImage(systemName: "circle"), for: .normal)
        chooseDatePickerButton.setImage(UIImage(systemName: "checkmark.circle.fill"), for: .normal)
    }

    @IBAction func addProductButton(_ sender: Any) {
        productNameTF.endEditing(true)
        guard let productName = productNameTF.text,  !productName.isEmpty  else {
            productNameTF.placeholder = "❗️Введите название продукта"
            return
        }
        
        let newFood = Food(name: productName, startDate: NSDate() as Date,
                           expirationDate: inputDate.getDateWithoutTime(),
                           foodPicture: uploadedImage.image)
            delegate?.recieved(food: newFood)
            dismiss(animated: true)
    }
    
    func countExpirationDate() -> Date { // НЕ РАБОТАЕТ
        let today = Date()
        guard let days = daysTF.text else {
            print("error 1")
            return today } // как лучше обработать в случае ошибки?
        let daysInt = Int(days)
        var dateComponent = DateComponents()
        dateComponent.day = daysInt
        if let countedExpirationDate = Calendar.current.date(byAdding: dateComponent, to: today) {
            return countedExpirationDate
        }
        else {
            return today
        }
    }
    
    @IBAction func datePicker(_ sender: UIDatePicker) {
        inputDate = sender.date // получаем дату истечения срока годности из datepicker
        print(inputDate.format() as Any)
    }
    
    @IBAction func cancelNewFoodVC(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    private func setButtonIcons() {

    }
    
    @objc private func didTapImageView(_ sender: UITapGestureRecognizer) {
        let actionSheet = UIAlertController(title: nil,
                                            message: nil,
                                            preferredStyle: .actionSheet)
        let camera = UIAlertAction(title: "Camera",
                                   style: .default) { _ in
            self.chooseImagePicker(source: .camera)
        }
        let photo = UIAlertAction(title: "Photo",
                                  style: .default) { _ in
            self.chooseImagePicker(source: .photoLibrary)
            
        }
        let cancel = UIAlertAction(title: "Cancel",
                                   style: .cancel)
        
        actionSheet.addAction(camera)
        actionSheet.addAction(photo)
        actionSheet.addAction(cancel)
        
        present(actionSheet, animated: true)
    }
    
}


extension HomeVC {
    func chooseImagePicker(source: UIImagePickerController.SourceType) {
        if UIImagePickerController.isSourceTypeAvailable(source) {
            let imagePicker = UIImagePickerController()
            imagePicker.allowsEditing = true
            imagePicker.sourceType = source
            imagePicker.delegate  = self
            present(imagePicker, animated: true, completion: nil)
        }
    }
}

extension  HomeVC:  UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        uploadedImage.image = info[.editedImage] as? UIImage
        uploadedImage.contentMode = .scaleAspectFill
        uploadedImage.clipsToBounds = true
        dismiss(animated: true)
    }
}

extension HomeVC: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.placeholder = ""
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField.text == "" {
            textField.placeholder = "❗️Введите название продукта"
        }
    }
}


