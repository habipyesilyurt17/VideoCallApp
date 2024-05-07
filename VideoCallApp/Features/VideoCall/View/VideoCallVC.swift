//
//  VideoCallVC.swift
//  VideoCallApp
//
//  Created by Habip Yesilyurt on 4.05.2024.
//

import UIKit
import AgoraUIKit
import AgoraRtcKit

final class VideoCallVC: UIViewController {
    
    @IBOutlet var videoView: AgoraVideoViewer!
    @IBOutlet weak var styleToggle: UISegmentedControl!

    private let viewModel = VideoCallViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.fetchToken(
            tokenType: "rtc",
            channel: VideoCallConstants.CHANNEL_NAME,
            role: .broadcaster
        ) {
            DispatchQueue.main.async {
                self.initializeAndJoinChannel()
                self.styleChange(self.styleToggle)
                self.view.bringSubviewToFront(self.styleToggle)
            }
        }
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        videoView.exit()
    }
    
    @IBAction func styleChange(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            videoView.style = .floating
        } else {
            videoView.style = .grid
        }
    }
    
    private func initializeAndJoinChannel() {
        videoView = AgoraVideoViewer(
            connectionData: AgoraConnectionData(
                appId: VideoCallConstants.APP_ID,
                rtcToken: viewModel.token
            )
        )
        videoView.fills(view: self.view)

        videoView.join(
            channel: VideoCallConstants.CHANNEL_NAME,
            with: viewModel.token,
            as: .broadcaster
        )
        configureMessageButton()
    }
    
    private func configureMessageButton() {
        let roundedView = UIView(frame: CGRect(x: view.bounds.width - 90, y: view.bounds.height - 120, width: 62, height: 62))
        roundedView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        roundedView.layer.cornerRadius = 31
        roundedView.clipsToBounds = true
        roundedView.backgroundColor = .systemGreen
        
        let messageButton = UIButton(type: .custom)
        messageButton.setImage(UIImage(systemName: "message.fill"), for: .normal)
        messageButton.tintColor = .systemBlue
        messageButton.addTarget(self, action: #selector(messageButtonTapped(_:)), for: .touchUpInside)
        messageButton.frame = CGRect(x: -9, y: 11, width: 80, height: 40)
        
        roundedView.addSubview(messageButton)
        view.addSubview(roundedView)
    }
    
    @objc func messageButtonTapped(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let chatVC = storyboard.instantiateViewController(withIdentifier: "ChatVC") as? ChatVC else {
            return
        }
        
        if let sheet = chatVC.sheetPresentationController {
            sheet.detents = [.medium()]
            sheet.prefersScrollingExpandsWhenScrolledToEdge = false
        }
        self.present(chatVC, animated: true, completion: nil)
    }
}
