//
//  ChatVC.swift
//  VideoCallApp
//
//  Created by Habip Yesilyurt on 6.05.2024.
//

import UIKit
import AgoraChat

final class ChatVC: UIViewController {
    
    var btnJoinLeave: UIButton!
    var etRecipient: UITextField!
    var scrollView: UITextView!
    var etMessageText: UITextField!
    var btnSendMessage: UIButton!
    
    var userId = "habip123"
    var token = "007eJxSYKj8sKDlG8ujpfLrD29I057MvYTxk8KlTssLJ/ct6N19Rk5DgcHM3NQi0Tg50cjYwsTEKCnZwtDc3Ng4JdUoxSzZwsDQxDnMMu2EJAND3c4lzIwMjAwsDIwMID4TmGQGkyxgUpwht1I3KT8pXzc5IzEvLzVHtyS1uEQ3P4+BARAAAP//5HUp3w=="
    var appKey = ChatConstants.APP_KEY
    var agoraChatClient: AgoraChatClient!
    var isJoined: Bool = false

    private let viewModel = ChatViewModel()
    
    override func viewDidLoad() {
        fetchChatToken()
        configureBtnJoinLeave()
        configureEtRecipient()
        configureScrollView()
        configureEtMessageText()
        configureBtnSendMessage()
        setupChatClient()
    }

    private func fetchChatToken() {
        viewModel.fetchToken(
            tokenType: "chat",
            channel: VideoCallConstants.CHANNEL_NAME
        ) {
            DispatchQueue.main.async {
                self.viewModel.registerUser(
                    username: AppLocalStorage.shared.readValue(forKey: LocalStorageKeys.USER_NAME) ?? "user",
                    password: "user123",
                    token: "007eJxTYAg7IyjXffl21c0DH2dqVN0U8+B47qNwWK/L9ZfBNc6JnxYpMJiZm1okGicnGhlbmJgYJSVbGJqbGxunpBqlmCVbGBia5LpYpjUEMjK4vDFmZmRgZWBkYGIA8RkYAJxbHR0="//self.chatViewModel.token
                )
            }
        }
    }
    
    func setupChatClient() {
        if (appKey.isEmpty) {
            showLog("You need to set your AppKey")
            return
        }
        let options = AgoraChatOptions(appkey: appKey)
        agoraChatClient = AgoraChatClient.shared()
        options.enableConsoleLog = true
        agoraChatClient.initializeSDK(with: options)
        agoraChatClient.chatManager?.add(self, delegateQueue: nil)
    }
    
    func showLog(_ text: String) -> Void {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: "", message: text, preferredStyle: .alert)
            self.present(alert, animated: true)
            alert.dismiss(animated: true, completion: nil)
        }
    }
    
    func displayMessage(messageText: String, isSentMessage: Bool) {
        DispatchQueue.main.async {
            self.scrollView.text.append(
                DateFormatter.localizedString(from: Date.now, dateStyle: .none, timeStyle: .medium)
                + ":  " + String(reflecting: messageText) + "\r\n"
            )
            self.scrollView.scrollRangeToVisible(NSRange(location: self.scrollView.text.count, length: 1))
        }
    }


    
    private func configureBtnJoinLeave() {
        btnJoinLeave = UIButton(type: .system)
        btnJoinLeave.frame = CGRect(x: 60, y: 50, width: 250, height: 30)
        btnJoinLeave.setTitle("Join", for: .normal)
        btnJoinLeave.tintColor = .white
        btnJoinLeave.addTarget(self, action: #selector(joinLeave), for: .touchUpInside)
        self.view.addSubview(btnJoinLeave)
    }
    
    @objc func joinLeave() {
        if isJoined {
            let result: AgoraChatError? = agoraChatClient.logout(true)
            guard result == nil else {
                showLog(result!.errorDescription)
                return
            }

            showLog("Signed out")
            DispatchQueue.main.async {
                self.btnJoinLeave.setTitle("Join", for: .normal)
                self.isJoined = false
            }
        } else {
            let result: AgoraChatError? = agoraChatClient.login(withUsername: userId, agoraToken: token)
            guard result == nil else {
                if (result!.code.rawValue == 200) {
                    isJoined = true
                    showLog("Already signed in")
                    DispatchQueue.main.async {
                        self.btnJoinLeave.setTitle("Leave", for: .normal)
                    }
                } else {
                    showLog(result!.errorDescription)
                }
                return
            }

            showLog("Signed in")
            isJoined = true

            DispatchQueue.main.async {
                self.btnJoinLeave.setTitle("Leave", for: .normal)
            }
        }
    }

    
    private func configureEtRecipient() {
        let textFieldPadding: CGFloat = 16
        let textFieldWidth = view.frame.width - 2 * textFieldPadding
        let etRecipient = UITextField(frame: CGRect(x: textFieldPadding, y: 100, width: textFieldWidth, height: 50))
        etRecipient.backgroundColor = .white
        let leftPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: etRecipient.frame.height))
        etRecipient.leftView = leftPaddingView
        etRecipient.leftViewMode = .always
        etRecipient.placeholder = "Enter recipient user ID"
        etRecipient.layer.cornerRadius = 8
        etRecipient.clipsToBounds = true
        self.view.addSubview(etRecipient)
    }
    
    private func configureScrollView() {
        scrollView = UITextView()
        scrollView.isEditable = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.layer.cornerRadius = 8
        scrollView.clipsToBounds = true
        self.view.addSubview(scrollView)
        configureScrollViewConstraint()
    }
    
    private func configureScrollViewConstraint() {
        let leadingConstraint = scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16)
        let trailingConstraint = scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        let topConstraint = scrollView.topAnchor.constraint(equalTo: view.topAnchor, constant: 200)
        let widthConstraint = scrollView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -32)
        let heightConstraint = scrollView.heightAnchor.constraint(equalToConstant: 100)
        NSLayoutConstraint.activate([leadingConstraint, trailingConstraint, topConstraint, widthConstraint, heightConstraint])
    }
    
    private func configureEtMessageText() {
        let messageBackgroundView = UIView()
        messageBackgroundView.backgroundColor = .white
        messageBackgroundView.layer.cornerRadius = 8
        messageBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(messageBackgroundView)
        configureMessageBackgroundViewConstraint(messageBackgroundView: messageBackgroundView)
        
        etMessageText = UITextField()
        etMessageText.placeholder = "Message"
        etMessageText.translatesAutoresizingMaskIntoConstraints = false
        messageBackgroundView.addSubview(etMessageText)
        configurEtMessageTextConstraint(etMessageText: etMessageText, messageBackgroundView: messageBackgroundView)
    }
    
    private func configureMessageBackgroundViewConstraint(messageBackgroundView: UIView) {
        let leadingConstraint = messageBackgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16)
        let heightConstraint = messageBackgroundView.heightAnchor.constraint(equalToConstant: 50)
        let topConstraint = messageBackgroundView.topAnchor.constraint(equalTo: view.topAnchor, constant: 320)
        let widthConstraint = messageBackgroundView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -(16 + 50 + 16))
        NSLayoutConstraint.activate([leadingConstraint, topConstraint, heightConstraint, widthConstraint])
    }
    
    private func configurEtMessageTextConstraint(etMessageText: UITextField, messageBackgroundView: UIView) {
        let textFieldLeadingConstraint = etMessageText.leadingAnchor.constraint(equalTo: messageBackgroundView.leadingAnchor, constant: 16)
        let textFieldTrailingConstraint = etMessageText.trailingAnchor.constraint(equalTo: messageBackgroundView.trailingAnchor, constant: -16)
        let textFieldTopConstraint = etMessageText.topAnchor.constraint(equalTo: messageBackgroundView.topAnchor)
        let textFieldBottomConstraint = etMessageText.bottomAnchor.constraint(equalTo: messageBackgroundView.bottomAnchor)
        NSLayoutConstraint.activate([textFieldLeadingConstraint, textFieldTrailingConstraint, textFieldTopConstraint, textFieldBottomConstraint])
    }
    
    private func configureBtnSendMessage() {
        btnSendMessage = UIButton(type: .system)
        btnSendMessage.setImage(UIImage(systemName: "paperplane"), for: .normal)
        btnSendMessage.tintColor = .white
        btnSendMessage.translatesAutoresizingMaskIntoConstraints = false
        btnSendMessage.addTarget(self, action: #selector(sendMessage), for: .touchUpInside)
        self.view.addSubview(btnSendMessage)
        configureBtnSendMessageConstraint()
    }
    
    private func configureBtnSendMessageConstraint() {
        let trailingConstraint = btnSendMessage.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        let topConstraint = btnSendMessage.topAnchor.constraint(equalTo: view.topAnchor, constant: 320)
        let heightConstraint = btnSendMessage.heightAnchor.constraint(equalToConstant: 50)
        let widthConstraint = btnSendMessage.widthAnchor.constraint(equalToConstant: 50)
        NSLayoutConstraint.activate([trailingConstraint, topConstraint, heightConstraint, widthConstraint])
    }
    
    
    @objc func sendMessage() {
        if etRecipient != nil && etMessageText != nil {
            let toSendName = etRecipient.text!.trimmingCharacters(in: .whitespaces)
            let content = etMessageText.text!.trimmingCharacters(in: .whitespaces)

            if (toSendName.isEmpty || content.isEmpty) {
                showLog("Enter a recipient name and a message.")
                return
            }

            let message = AgoraChatMessage(
                conversationID: toSendName,
                from: agoraChatClient.currentUsername!,
                to: toSendName,
                body: AgoraChatTextMessageBody(text: content),
                ext: nil
            )

            agoraChatClient.chatManager?.send(message, progress: nil) { _, err in
                if let err = err {
                    self.showLog("Error occurred when sending the message. \(err.errorDescription ?? "")")
                } else {
                    self.showLog("Message sent successfully.")
                    DispatchQueue.main.async {
                        self.displayMessage(messageText: content, isSentMessage: true)
                        self.etMessageText.text = ""
                    }
                }
            }
        }
    }
}

extension ChatVC: AgoraChatManagerDelegate {
    func messagesDidReceive(_ aMessages: [AgoraChatMessage]) {
        for message in aMessages {
            let msgBody = message.body as! AgoraChatTextMessageBody

            DispatchQueue.main.async {
                self.displayMessage(messageText: msgBody.text, isSentMessage: false)
            }

            showLog("Received a message from \(message.from)")
        }
    }
}

extension ChatVC: AgoraChatClientDelegate {
    func connectionStateDidChange(_ aConnectionState: AgoraChatConnectionState) {
        if aConnectionState == .connected {
            showLog("Connected to the chat server.")
        } else {
            if isJoined {
                showLog("Disconnected from the chat server.")
                isJoined = false
            }
        }
    }

    func tokenWillExpire(_ aErrorCode: AgoraChatErrorCode) {
        showLog("Token will expire (log in using new token)")
    }

    func tokenDidExpire(_ aErrorCode: AgoraChatErrorCode) {
        showLog("Token expired (log in using new token)")
    }
}
