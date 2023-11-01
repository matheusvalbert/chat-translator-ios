//
//  EditProfileViewController.swift
//  Profile
//
//  Created by Matheus Valbert on 12/08/23.
//

import UIKit
import UIComponents

public class EditProfileViewController: CTScrollViewController {
    
    let username = CTTextField(placeholder: "Username", contentType: .username, keyboardType: .asciiCapable, tintColor: Colors.purple, clearButton: .whileEditing)
    let language = CTTextField(placeholder: "Language", contentType: .countryName, tintColor: .clear, clearButton: .never, canEdit: false)
    let languagePicker = CTLanguagePickerView(action: #selector(donePicker))
    final var cancelButton: UIBarButtonItem?
    final var doneButton: UIBarButtonActivityIndicator?

    public var viewModel: ProfileViewModel?
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configure()
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchProfile()
    }
    
    private func configureViewController() {
        cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(dismissView))
        doneButton = UIBarButtonActivityIndicator(barButtonSystemItem: .done, target: self, action: #selector(doneView))
        navigationItem.leftBarButtonItem = cancelButton
        navigationItem.rightBarButtonItem = doneButton
        title = "Edit Profile"
    }
    
    private func configure() {
        contentView.addSubview(username)
        contentView.addSubview(language)
        
        NSLayoutConstraint.activate([
            username.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor),
            username.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: -1),
            username.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 1),
            username.heightAnchor.constraint(equalToConstant: 40),
            
            language.topAnchor.constraint(equalTo: username.bottomAnchor, constant: -1),
            language.leadingAnchor.constraint(equalTo: username.leadingAnchor),
            language.trailingAnchor.constraint(equalTo: username.trailingAnchor),
            language.heightAnchor.constraint(equalToConstant: 40),
        ])
        
        language.inputView = languagePicker
        language.inputAccessoryView = languagePicker.toolBar
        
        username.delegate = self
        languagePicker.delegate = self
    }
    
    private func fetchProfile() {
        username.text = viewModel?.profile?.username
        language.text = viewModel?.profile?.language.rawValue.localizedCapitalized
        languagePicker.update(language: language.text!)
    }
    
    private func updateProfile() {
        guard let username = self.username.text, let language = self.language.text else { return }
        
        Task {
            startLoading()
            await viewModel?.updateProfile(username: username, language: language)
            finishLoading()
            dismiss(animated: true)
            NotificationCenter.default.post(name: NSNotification.Name("ModalDisposed"), object: nil)
        }
    }
    
    private func startLoading() {
        isModalInPresentation = true
        username.isEnabled = false
        language.isEnabled = false
        cancelButton?.isEnabled = false
        doneButton?.startLoading()
    }
    
    private func finishLoading() {
        isModalInPresentation = false
        username.isEnabled = true
        language.isEnabled = true
        cancelButton?.isEnabled = true
        doneButton?.stopLoading()
    }
}

extension EditProfileViewController {
    
    @objc private func dismissView() {
        dismiss(animated: true)
    }
    
    @objc private func doneView() {
        updateProfile()
    }
    
    @objc private func donePicker() {
        language.resignFirstResponder()
        updateProfile()
    }
}

extension EditProfileViewController: UIPickerViewDelegate {
    
    public func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        languagePicker.languages[row]
    }
    
    public func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        language.text = languagePicker.languages[row]
    }
}

extension EditProfileViewController: UITextFieldDelegate {
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        language.becomeFirstResponder()
    }
}
