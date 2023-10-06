//
//  MailView.swift
//  Presentation
//
//  Created by Lee Myeonghwan on 2023/10/05.
//  Copyright © 2023 com.lito. All rights reserved.
//

import UIKit
import SwiftUI
import MessageUI

struct MailView: UIViewControllerRepresentable {
    @Binding var isShowing: Bool

    func makeUIViewController(context: Context) -> UIViewController {
        guard MFMailComposeViewController.canSendMail() else {
            // 메시지를 보낼 수 없는 경우 핸들
            return UIViewController()
        }
        
        let mailViewController = MFMailComposeViewController()
        mailViewController.setToRecipients(["learningit.korea@gmail.com"])
        mailViewController.setSubject("이름 변경 문의")
        mailViewController.setMessageBody("""
        변경하고자 하는 이름:
        """
, isHTML: false)
        mailViewController.mailComposeDelegate = context.coordinator
        return mailViewController
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        // Nothing to do here
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, MFMailComposeViewControllerDelegate {
        var parent: MailView

        init(_ parent: MailView) {
            self.parent = parent
        }

        func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
            parent.isShowing = false
        }
    }
}
