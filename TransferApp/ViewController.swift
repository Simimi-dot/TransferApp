//
//  ViewController.swift
//  TransferApp
//
//  Created by Егор Астахов on 20.10.2021.
//

import UIKit
// Класс делегат
class ViewController: UIViewController, UpdatableDataController, DataUpdateProtocol {
    

    @IBOutlet var dataLabel: UILabel!
    
    var updatedData: String = "Test data"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateLabel(withText: updatedData)
    }
    
    private func updateLabel(withText text: String) {
        dataLabel.text = text
    }
    //MARK: - Передача данных с помощью делегрования
    func onDataUpdate(data: String) {
        updatedData = data
        updateLabel(withText: data)
    }
    
    
    
    //MARK: - Передача данных с помощью segue
    // Передача данных с помощью segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Определяем идентификатор segue
        switch segue.identifier {
        case "toEditScreen":
            // Обрабатываем переход
            prepareEditScreen(segue)
        default:
            break
        }
    }
    // подготовка к переходу на экран редактирования
    private func prepareEditScreen(_ segue: UIStoryboardSegue) {
        // безопасно извлекаем опциональное значение
        guard let destinationController = segue.destination as? SecondViewController else {
            return
        }
        destinationController.updatingData = dataLabel.text ?? ""
    }

    
    // MARK: - Передача данных с помощью свойств
    @IBAction func editDataWithProperty(_ sender: UIButton) {
        // Получаем вью контроллер в который происходит переход
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        var editScreen = storyBoard.instantiateViewController(withIdentifier: "SecondViewController") as! UpdatingDataController
        // Передаем данные
        editScreen.updatingData = dataLabel.text ?? ""
        // Переходим к следующему экрану
        self.navigationController?.pushViewController(editScreen as! UIViewController, animated: true)
    }
    
    
    // Экшн с помощью которого мы переходим обратно с последнего экрана на первый
    @IBAction func unwindToFirstScreen(_ segue: UIStoryboardSegue) {
        
    }
    // переход от А к Б
    // Передача данных с помощью свойства и установка делегата
    @IBAction func editDataWithDelegate(_ sender: UIButton) {
        // получаем вью контроллер
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let editScreen = storyboard.instantiateViewController(withIdentifier: "SecondViewController") as! SecondViewController
        // передаем данные
        editScreen.updatingData = dataLabel.text ?? ""
        // устанавливаем текущий класс в качестве делегата
        editScreen.handleUpdatedDataDelegate = self
        // открываем следующий экран
        self.navigationController?.pushViewController(editScreen, animated: true)
    }
    
    // Переход от А к Б
    // Передача данных с помощью свойства и инициализации замыкания
    @IBAction func editDataWithClosure(_ sender: UIButton) {
        // Получаем вью контроллер
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let editScreen = storyboard.instantiateViewController(withIdentifier: "SecondViewController") as! SecondViewController
        // Передаем данные
        editScreen.updatingData = dataLabel.text ?? ""
        // Передаем необходимое замыкание
        editScreen.completionHandler = { [unowned self] updatedValue in
            updatedData = updatedValue
            updateLabel(withText: updatedValue)
        }
        // открываем следующий экран
        self.navigationController?.pushViewController(editScreen, animated: true)
    }


}

