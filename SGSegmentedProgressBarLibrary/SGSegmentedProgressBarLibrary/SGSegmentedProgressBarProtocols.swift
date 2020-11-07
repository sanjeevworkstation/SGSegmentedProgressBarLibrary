//
//  SGSegmentedProgressBarProtocols.swift
//  SGSegmentedProgressBarLibrary
//
//  Created by Sanjeev Gautam on 07/11/20.
//

import Foundation
import UIKit

public protocol SGSegmentedProgressBarDelegate: class {
    func segmentedProgressBarFinished(finishedIndex: Int, isLastIndex: Bool)
}

public protocol SGSegmentedProgressBarDataSource: class {
    var numberOfSegments: Int { get }
    var segmentDuration: TimeInterval { get }
    var paddingBetweenSegments: CGFloat { get }
    var trackColor: UIColor { get }
    var progressColor: UIColor { get }
    var roundCornerType: SGCornerType { get }
}

public enum SGCornerType {
    case roundCornerSegments(cornerRadious: CGFloat)
    case roundCornerBar(cornerRadious: CGFloat)
    case none
}
