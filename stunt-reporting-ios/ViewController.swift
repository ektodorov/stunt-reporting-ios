//
//  ViewController.swift
//  stunt-reporting-ios
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var buttonSendString: UIButton!
    @IBOutlet weak var buttonSendBitmap: UIButton!
    @IBOutlet weak var buttonSendFile: UIButton!
    @IBOutlet weak var buttonSendClientInfo: UIButton!
    @IBOutlet weak var buttonSetServerUrl: UIButton!
    
    var mSequence: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onButtonSendString(_ sender: UIButton) {
        print("\(#line), \(#function)")
        
        mSequence += 1
        ConstantsStunt.sendMessage(sequence: mSequence)
    }
    
    @IBAction func onButtonSendBitmap(_ sender: UIButton) {
        print("\(#line), \(#function)")
        
        mSequence += 1
        let bundle = Bundle.main
        let path = bundle.path(forResource: "arrowLeft", ofType: "png")
        ConstantsStunt.sendImage(sequence: mSequence, filePath: path!)
    }
    
    @IBAction func onButtonSendFile(_ sender: UIButton) {
        print("\(#line), \(#function)")
        
        mSequence += 1
        let bundle = Bundle.main
        let path = bundle.path(forResource: "clipboard", ofType: "txt")
        ConstantsStunt.sendFile(sequence: mSequence, filePath: path!)
    }
    
    @IBAction func onButtonSendClientInfo(_ sender: UIButton) {
        print("\(#line), \(#function)")
        
        mSequence += 1
        ConstantsStunt.sendClientInfo(sequence: mSequence)
    }
    
    @IBAction func onButtonSetServerUrl(_ sender: UIButton) {
        print("\(#line), \(#function)")
    }
    
}

