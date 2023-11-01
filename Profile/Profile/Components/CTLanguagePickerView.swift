//
//  CTLanguagePickerView.swift
//  Profile
//
//  Created by Matheus Valbert on 12/08/23.
//

import UIKit
import DataComponents

class CTLanguagePickerView: UIPickerView {

    let languages = ["English","German", "Spanish", "Portuguese"]
    
    var toolBar: UIToolbar?
    var btnDone: UIBarButtonItem?
    let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(action: Selector) {
        self.init(frame: .zero)
        set(action: action)
    }
    
    private func configure() {
        dataSource = self
    }
    
    private func set(action: Selector) {
        toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: frame.width, height: 44))
        btnDone = UIBarButtonItem(barButtonSystemItem: .done, target: self.inputView, action: action)
        toolBar?.items = [spaceButton, btnDone!]
    }
    
    func update(language: String) {
        let languageIndex = languages.firstIndex(of: language)
        selectRow(languageIndex ?? 0, inComponent: 0, animated: false)
    }
}

extension CTLanguagePickerView: UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        4
    }
}
