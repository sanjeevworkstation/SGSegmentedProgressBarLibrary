//
//  ViewController.swift
//  Example
//
//  Created by Sanjeev Gautam on 07/11/20.
//

import UIKit
import SGSegmentedProgressBarLibrary 

class ViewController: UIViewController {

    var segmentedBar: SGSegmentedProgressBar?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let rect = CGRect(x: 10, y: 100, width: self.view.frame.size.width-20, height: 10)
        self.segmentedBar = SGSegmentedProgressBar(frame: rect, delegate: self, dataSource: self)
        self.view.addSubview(self.segmentedBar!)
    }

    @IBAction func startAction(_ sender: UIButton) {
        self.segmentedBar?.start()
        
        //self.segmentedBar?.setProgressManually(index: 0, progressPercentage: 50)
    }
    
    @IBAction func pauseAction(_ sender: UIButton) {
        self.segmentedBar?.pause()
    }
    
    @IBAction func resumeAction(_ sender: UIButton) {
        self.segmentedBar?.resume()
    }
    
    @IBAction func restartAction(_ sender: UIButton) {
        self.segmentedBar?.restart()
    }
    
    @IBAction func peviousAction(_ sender: UIButton) {
        self.segmentedBar?.previousSegment()
    }
    
    @IBAction func nextAction(_ sender: UIButton) {
        self.segmentedBar?.nextSegment()
    }
    
    @IBAction func restartCurrentAction(_ sender: UIButton) {
        self.segmentedBar?.restartCurrentSegment()
    }
}

extension ViewController: SGSegmentedProgressBarDelegate, SGSegmentedProgressBarDataSource {
    
    func segmentedProgressBarFinished(finishedIndex: Int, isLastIndex: Bool) {
        print("finishedIndex: \(finishedIndex)")
    }
    
    var numberOfSegments: Int {
        return 5
    }
    
    var segmentDuration: TimeInterval {
        return 5
    }
    
    var paddingBetweenSegments: CGFloat {
        return 3
    }
    
    var trackColor: UIColor {
        return UIColor.red.withAlphaComponent(0.2)
    }
    
    var progressColor: UIColor {
        return UIColor.red
    }
    
    var roundCornerType: SGCornerType {
        //return .roundCornerEverySegment(cornerRadious: 5)
        return .roundCornerBar(cornerRadious: 5)
    }
}
