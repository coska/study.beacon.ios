//
//  SmsViewController.swift
//  BeaconData
//
//  Created by thomas on 2016-04-17.
//  Copyright © 2016 coska.com. All rights reserved.
//


import UIKit
import MessageUI

class SmsViewController: UIViewController, MFMessageComposeViewControllerDelegate {
	
	var phoneNo = ""
	var msgToSend = ""
	
	override func viewDidLoad() {
		super.viewDidLoad()
	}
	
	override func viewWillDisappear(animated: Bool) {
		self.navigationController?.navigationBarHidden = false
	}
	
	func setText(phone:String, message:String)
	{
		phoneNo = phone
		msgToSend = message
	}
	
	@IBAction func sendText(sender: AnyObject) {
		if (MFMessageComposeViewController.canSendText()) {
			let vc = MFMessageComposeViewController()
			vc.body = msgToSend
			vc.recipients = [phoneNo]
			vc.messageComposeDelegate = self
			
			self.presentViewController(vc, animated: true, completion: nil)
		}
	}
	
	func messageComposeViewController(vc: MFMessageComposeViewController, didFinishWithResult result: MessageComposeResult) {
		
//		switch (result.value) {
//		case MessageComposeResultCancelled.value:
//			println("Message was cancelled")
//			self.dismissViewControllerAnimated(true, completion: nil)
//		case MessageComposeResultFailed.value:
//			println("Message failed")
//			self.dismissViewControllerAnimated(true, completion: nil)
//		case MessageComposeResultSent.value:
//			println("Message was sent")
//			self.dismissViewControllerAnimated(true, completion: nil)
//		default:
//			break;
//		}
		
		self.dismissViewControllerAnimated(true, completion: nil)
	}
	
}
