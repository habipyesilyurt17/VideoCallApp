//
//  VideoCallVC.swift
//  VideoCallApp
//
//  Created by Habip Yesilyurt on 4.05.2024.
//

import UIKit
import AgoraUIKit

final class VideoCallVC: UIViewController {
    
    @IBOutlet var videoView: AgoraVideoViewer!
    @IBOutlet weak var styleToggle: UISegmentedControl!
    
    // Fill the App ID of your project generated on Agora Console.
    let appId: String = ""

    // Fill the temp token generated on Agora Console.
    let token: String? = ""

    // Fill the channel name.
    let channelName: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeAndJoinChannel()
        styleChange(styleToggle)
        view.bringSubviewToFront(styleToggle)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        // burayı kontrol et
//        if videoView != nil {
//            videoView.exit()
//        }
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
                appId: appId,
                rtcToken: token
            )
        )
        videoView.fills(view: self.view)

        videoView.join(
            channel: channelName,
            with: token,
            as: .broadcaster
        )
    }
}
