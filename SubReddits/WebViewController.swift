//
//  WebViewController.swift
//  SubReddits
//
//  Created by Uldis Zingis on 14/11/16.
//  Copyright © 2016 Uldis Zingis. All rights reserved.
//

import UIKit

class WebViewController: UIViewController {

    @IBOutlet weak var webView: UIWebView!
    var urlString: String?

    override func viewDidLoad() {
        super.viewDidLoad()

        guard let urlString = urlString, let url = URL(string: urlString) else { return }
        let request = URLRequest(url: url)
        webView.loadRequest(request)
    }
}
