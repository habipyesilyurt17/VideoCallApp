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
            DispatchQueue.main.sync {
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
    }
}
