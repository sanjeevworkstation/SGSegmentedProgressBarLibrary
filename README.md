# SGSegmentedProgressBarLibrary
SGSegmentedProgressBarLibrary By Custom UIView

<div><img src="https://github.com/sanjeevworkstation/SGImages/blob/master/Segmented%20Progress%20Bar.png" width="30%" height="30%"></div>


# How to use:

Declaration

var segmentBar: SGSegmentedProgressBar?

Add Progress View

let rect = CGRect(x: 20, y: 100, width: self.view.frame.size.width-40, height: 2)

self.segmentBar = SGSegmentedProgressBar(frame: rect, delegate: self, dataSource: self)

self.view.addSubview(self.segmentBar!)

Delegates & DataSources

extension ViewController: SGSegmentedProgressBarDelegate, SGSegmentedProgressBarDataSource {

func segmentedProgressViewFinished(finishedIndex: Int, isLastIndex: Bool) {
    
}

var numberOfSegments: Int {
    return 5
}

var segmentDuration: TimeInterval {
    return 5 // seconds
}

var paddingBetweenSegments: CGFloat {
    return 3 // gap between segments
}

var trackColor: UIColor {
    return UIColor.red.withAlphaComponent(0.3)
}

var progressColor: UIColor {
    return UIColor.red
}
}

# Properties:

// GET PAUSE STATE

let isPaused = self.segmentBar?.isPaused

// CURRENT SEGMENT INDEX

let currentPlayingIndex = self.segmentBar?.currentIndex

# Actions:

// START

self.segmentBar?.start()

// PAUSE

self.segmentBar?.pause()

// RESUME

self.segmentBar?.resume()

// PLAY NEXT

self.segmentBar?.nextSegment()

// PLAY PREVIOUS

self.segmentBar?.previousSegment()

// RESTART

self.segmentBar?.restart()

// RESTART CURRENT

self.segmentBar?.restartCurrentSegment()

// RESET

self.segmentBar?.reset()
