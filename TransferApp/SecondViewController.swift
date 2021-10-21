//
//  SecondViewController.swift
//  TransferApp
//
//  Created by Егор Астахов on 20.10.2021.
//

import UIKit

class SecondViewController: UIViewController, UpdatingDataController {

    @IBOutlet var dataTextField: UITextField!
    
    var updatingData: String = ""
    // Делегатор
    var handleUpdatedDataDelegate: DataUpdateProtocol?
    // Передача данных с помощью замыкания
    var completionHandler: ((String) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    // Метод относится к жизненному циклу view controller, он вызывается при каждом отображении сцены на экране, а не только при первом, как viewDidLoad
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateTextFieldData(withText: updatingData)
    }
    
    private func updateTextFieldData(withText text: String) {
        dataTextField.text = text
    }
    //MARK: - Передача данных с помощью segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // определяем идентификатор segue
        switch segue.identifier {
        case "toFirstScreen":
            // обрабатываем переход
            prepareFirstScreen(segue)
        default:
            break
        }
    }
    // Подготовка к переходу на первый экран
    private func prepareFirstScreen(_ segue: UIStoryboardSegue) {
        // безопасно извлекаем опциональное значение
        guard let destinationController = segue.destination as? ViewController else {
            return
        }
        destinationController.updatedData = dataTextField.text ?? ""
    }
    // MARK: - Передача данных с помощью свойств
    // При нажатии на кнопку данные которые были написаны в текстовом поле передаются в лейбл в view controller 
    @IBAction func saveDataWithProperty(_ sender: UIButton) {
        self.navigationController?.viewControllers.forEach({ viewController in
            (viewController as? ViewController)?.updatedData = dataTextField.text ?? ""
        })
    }
    // Переход от Б к А
    // Передача данных с помощью делегата
    @IBAction func saveDataWithDelegate(_ sender: UIButton) {
        // получаем обновленные данные
        let updatedData = dataTextField.text ?? ""
        // вызываем метод делегата
        handleUpdatedDataDelegate?.onDataUpdate(data: updatedData)
        // возвращаемся на предыдущий экран
        navigationController?.popViewController(animated: true)
    }
    
    // Переход от Б к А
    // Передача данных с помощью замыкания
    @IBAction func saveDataWithClosure(_ sender: UIButton) {
        // получаем обновленные данные
        let updatedData = dataTextField.text ?? ""
        // Вызываем замыкание
        completionHandler?(updatedData)
        // Возвращаемся на предыдущий экран
        navigationController?.popViewController(animated: true)
    }
    
    

}
