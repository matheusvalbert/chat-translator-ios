//
//  CTTextField.swift
//  UIComponents
//
//  Created by Matheus Valbert on 03/08/23.
//

import UIKit

public class CTTextField: UITextField {
    
    var canEdit: Bool = true
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public convenience init(placeholder: String, contentType: UITextContentType, isPassword: Bool = false, returnKeyType: UIReturnKeyType = .next, keyboardType: UIKeyboardType = .default, tintColor: UIColor = Colors.purple, clearButton: ViewMode = .whileEditing, canEdit: Bool = true) {
        self.init(frame: .zero)
        set(placeholder: placeholder, contentType: contentType, isPassword: isPassword, returnKeyType: returnKeyType, keyboardType: keyboardType, tintColor: tintColor, clearButton: clearButton, canEdit: canEdit)
    }
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        
        delegate = self
        
        layer.borderWidth = 1
        layer.borderColor = UIColor.secondarySystemFill.cgColor
        
        leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 50))
        leftViewMode = .always
        
        textColor = .label
        
        backgroundColor = .secondarySystemBackground
        autocorrectionType = .no
        clearButtonMode = .whileEditing
    }
    
    private func set(placeholder: String, contentType: UITextContentType, isPassword: Bool, returnKeyType: UIReturnKeyType, keyboardType: UIKeyboardType, tintColor: UIColor, clearButton: ViewMode, canEdit: Bool) {
        self.placeholder = placeholder
        self.returnKeyType = returnKeyType
        self.keyboardType = keyboardType
        textContentType = contentType
        isSecureTextEntry = isPassword
        self.tintColor = tintColor
        clearButtonMode = clearButton
        self.canEdit = canEdit
    }
}

extension CTTextField: UITextFieldDelegate {
    
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        canEdit
    }
}
