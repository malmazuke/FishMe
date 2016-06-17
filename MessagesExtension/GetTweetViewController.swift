//
//  MessagesViewController.swift
//  MessagesExtension
//
//  Created by Mark Feaver on 17/06/16.
//  Copyright © 2016 Mark Feaver. All rights reserved.
//

import UIKit
import Messages

class GetTweetViewController: MSMessagesAppViewController {
    
    static let storyboardIdentifier = "GetTweetViewController"
    
    weak var delegate: GetTweetViewControllerDelegate?
    
    @IBOutlet var fishMeButton: UIButton!
    @IBOutlet var quoteLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        quoteLabel.alpha = 0.0
    }
    
    @IBAction func tappedFishButton(_ sender: AnyObject) {
        let randomIndex = Int(arc4random_uniform(UInt32(philFishTopTweets.count - 1)))
        let currentText = quoteLabel.text
        while quoteLabel.text == currentText {
            quoteLabel.text = philFishTopTweets[randomIndex]
        }
        
        if quoteLabel.alpha == 0.0 {
            UIView.animate(withDuration: 1.0, animations: { 
                self.fishMeButton.alpha = 0.0
            })
            UIView.animate(withDuration: 3.0, animations: {
                self.quoteLabel.alpha = 1.0
                }, completion: { (_) in
                    self.delegate?.getTweetViewController(self, didGetTweet: self.quoteLabel.text!)
            })
        }
    }

    static func renderTweet(tweet: String) -> UIImage? {
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 300.0, height: 300.0))
        let image = renderer.image { context in
            let backgroundImage = #imageLiteral(resourceName: "grossfishcrop")
            backgroundImage.draw(in: CGRect(x: 0.0, y: 0.0, width: 300.0, height: 300.0), blendMode: .normal, alpha: 0.2)
            
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.alignment = .center
            
            let attrs = [NSFontAttributeName: UIFont(name: "HelveticaNeue", size: 36)!, NSParagraphStyleAttributeName: paragraphStyle, NSForegroundColorAttributeName: UIColor.gray()]
            
            let string = NSString(string: tweet)
            string.draw(with: CGRect(x: 10.0, y: 20.0, width: 280.0, height: 260.0), options: .usesLineFragmentOrigin, attributes: attrs, context: nil)
        }
        
        return image
    }
}

protocol GetTweetViewControllerDelegate: class {
    func getTweetViewController(_ controller: GetTweetViewController, didGetTweet tweet: String)
}
