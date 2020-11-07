//
//  SGSegmentedProgressBar.swift
//  SGSegmentedProgressBarLibrary
//
//  Created by Sanjeev Gautam on 07/11/20.
//

import Foundation
import UIKit

public final class SGSegmentedProgressBar: UIView {
    
    private weak var delegate: SGSegmentedProgressBarDelegate?
    private weak var dataSource: SGSegmentedProgressBarDataSource?
    
    private var numberOfSegments: Int { get { return self.dataSource?.numberOfSegments ?? 0 } }
    private var segmentDuration: TimeInterval { get { return self.dataSource?.segmentDuration ?? 5 } }
    private var paddingBetweenSegments: CGFloat { get { return self.dataSource?.paddingBetweenSegments ?? 5 } }
    private var trackColor: UIColor { get { return self.dataSource?.trackColor ?? UIColor.red.withAlphaComponent(0.3) } }
    private var progressColor: UIColor { get { return self.dataSource?.progressColor ?? UIColor.red } }
    
    private var segments = [UIView]()
    private var timer: Timer?
    
    private var SEGMENT_MAX_WIDTH: CGFloat = 0
    private let PROGRESS_SPEED: Double = 100
    private var PROGRESS_INTERVAL: CGFloat {
        let value = (self.segmentDuration) * PROGRESS_SPEED
        let result = SEGMENT_MAX_WIDTH/CGFloat(value)
        return result
    }
    private var TIMER_TIMEINTERVAL: Double {
        return 1/PROGRESS_SPEED
    }
    
    // MARK:- Properties
    public private (set) var isPaused: Bool = false
    public private (set) var currentIndex: Int = 0
    
    // MARK:- Initializer
    internal required init(coder aDecoder: NSCoder) {
        fatalError("This class does not support NSCoding")
    }
    
    public init(frame: CGRect, delegate: SGSegmentedProgressBarDelegate, dataSource: SGSegmentedProgressBarDataSource) {
        super.init(frame : frame)
        
        self.delegate = delegate
        self.dataSource = dataSource
        
        self.drawSegments()
    }
    
    // MARK:- Private
    private func drawSegments() {
        
        let remainingWidth = self.frame.size.width - (self.paddingBetweenSegments * CGFloat(self.numberOfSegments-1))
        let widthOfSegment = remainingWidth/CGFloat(self.numberOfSegments)
        let heightOfSegment = self.frame.size.height
        SEGMENT_MAX_WIDTH = widthOfSegment

        var originX: CGFloat = 0
        let originY: CGFloat = 0
        
        for index in 0..<self.numberOfSegments {
            originX = (CGFloat(index) * widthOfSegment) + (CGFloat(index) * self.paddingBetweenSegments)
            
            let frameOfTrackView = CGRect(x: originX, y: originY, width: widthOfSegment, height: heightOfSegment)
            
            let trackView = self.createProgressView(backgroundColor: trackColor)
            trackView.frame = frameOfTrackView
            self.addSubview(trackView)
            
            if let cornerType = self.dataSource?.roundCornerType {
                switch cornerType {
                case .roundCornerSegments(let cornerRadious):
                    trackView.borderAndCorner(cornerRadious: cornerRadious, borderWidth: 0, borderColor: nil)
                case .roundCornerBar(let cornerRadious):
                    if index == 0 {
                        trackView.roundCorners(corners: [.topLeft, .bottomLeft], radius: cornerRadious)
                    } else if index == self.numberOfSegments-1 {
                        trackView.roundCorners(corners: [.topRight, .bottomRight], radius: cornerRadious)
                    }
                case .none:
                    break
                }
            }
            
            let deafultFrameOfProgressView = CGRect(x: 0, y: 0, width: 0, height: heightOfSegment)
            let progressView = self.createProgressView(backgroundColor: progressColor)
            progressView.frame = deafultFrameOfProgressView
            trackView.addSubview(progressView)
            self.segments.append(progressView)
        }
    }
    
    private func createProgressView(backgroundColor: UIColor) -> UIView {
        let progressView = UIView()
        progressView.clipsToBounds = true
        progressView.isUserInteractionEnabled = false
        progressView.backgroundColor = backgroundColor
        return progressView
    }
    
    // MARK:- Timer
    private func setUpTimer() {
        if self.timer == nil {
            self.timer = Timer.scheduledTimer(timeInterval: TIMER_TIMEINTERVAL, target: self, selector: #selector(animationTimerMethod), userInfo: nil, repeats: true)
        }
    }
    
    @objc private func animationTimerMethod() {
        
        if self.isPaused { return }
        self.animateSegment()
    }
    
    // MARK:- Animation
    private func animateSegment() {
        if self.currentIndex < self.segments.count {
            let progressView = self.segments[self.currentIndex]
            let lastProgress = progressView.frame.size.width
            let newProgress = lastProgress + PROGRESS_INTERVAL
            progressView.updateWidth(newWidth: newProgress)
            
            if newProgress >= SEGMENT_MAX_WIDTH {
                if self.currentIndex == self.numberOfSegments-1 {
                    self.delegate?.segmentedProgressBarFinished(finishedIndex: self.currentIndex, isLastIndex: true)
                } else {
                    self.delegate?.segmentedProgressBarFinished(finishedIndex: self.currentIndex, isLastIndex: false)
                }
                
                if self.currentIndex < self.numberOfSegments-1 {
                    self.currentIndex = self.currentIndex + 1
                    
                    let progressView = self.segments[self.currentIndex]
                    progressView.updateWidth(newWidth: 0)
                    
                } else {
                    self.timer?.invalidate()
                    self.timer = nil
                }
            }
        }
    }
    
    // MARK:- Actions
    public func start() {
        self.setUpTimer()
    }
    
    public func pause() {
        self.isPaused = true
    }
    
    public func resume() {
        self.isPaused = false
    }
    
    public func nextSegment() {
        if self.currentIndex < self.segments.count-1 {
            self.isPaused = true
            
            let progressView = self.segments[self.currentIndex]
            progressView.updateWidth(newWidth: SEGMENT_MAX_WIDTH)
            
            self.currentIndex = self.currentIndex + 1
            
            self.isPaused = false
            
            if self.timer == nil {
                self.start()
            } else {
                self.animateSegment()
            }
        }
    }
    
    public func previousSegment() {
        
        if self.currentIndex > 0 {
            self.isPaused = true
            
            let currentProgressView = self.segments[self.currentIndex]
            currentProgressView.updateWidth(newWidth: 0)
            
            self.currentIndex = self.currentIndex - 1
            
            let progressView = self.segments[self.currentIndex]
            progressView.updateWidth(newWidth: 0)
            
            self.isPaused = false
            
            if self.timer == nil {
                self.start()
            } else {
                self.animateSegment()
            }
        }
    }
    
    public func restart() {
        self.reset()
        self.start()
    }
    
    public func reset() {
        self.isPaused = true
        
        self.timer?.invalidate()
        self.timer = nil
        
        for index in 0..<numberOfSegments {
            let progressView = self.segments[index]
            progressView.updateWidth(newWidth: 0)
        }
        
        self.currentIndex = 0
        self.isPaused = false
    }
    
    public func restartCurrentSegment() {
        self.isPaused = true
        
        let currentProgressView = self.segments[self.currentIndex]
        currentProgressView.updateWidth(newWidth: 0)
        
        self.isPaused = false
        
        if self.timer == nil {
            self.start()
        } else {
            self.animateSegment()
        }
    }
    
    // MARK:- Set Progress Manually
    public func setProgressManually(index: Int, progressPercentage: CGFloat) {
        
        if index < self.segments.count && index >= 0 {
            self.timer?.invalidate()
            self.timer = nil
            
            self.currentIndex = index
            var percentage = progressPercentage
            if progressPercentage > 100 {
                percentage = 100
            }
            
            let currentProgressView: UIView = self.segments[self.currentIndex]
            let width: CGFloat = (SEGMENT_MAX_WIDTH * percentage) / 100
            currentProgressView.updateWidth(newWidth: width)
        }
    }
}
