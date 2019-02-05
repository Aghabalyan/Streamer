//
//  SegmentCell.swift
//  Streamer
//
//  Created by Varmtech on 2/5/19.
//  Copyright © 2019 Varmtech. All rights reserved.
//

import UIKit

class SegmentCell: UITableViewCell {
    
    
    @IBOutlet weak var chapterElementTypeImageView: UIImageView!
    @IBOutlet weak var chapterElementTypeLabel: UILabel!
    @IBOutlet weak var chapterElementDurationLabel: UILabel!
    @IBOutlet weak var sliderSegment: UISlider!
    @IBOutlet weak var riseLabel: UILabel!
    
    var steps: Steps? {
        didSet{
            guard let steps = steps else { return }
            self.chapterElementTypeLabel.text = steps.name
            self.riseLabel.text = steps.rise
            //chapterElementTypeImageView.image = UIImage(named: steps.stageIcon ?? "start_icon")
            //chapterElementTypeImageView.tintColor = UIColor.white
            chapterElementTypeImageView.tintColor = UIColor(red:0.36, green:0.42, blue:0.48, alpha:1)
            
//            let hours = time / 3600
//            let minutes = (time / 60) % 60
//            let seconds = time % 60
//            return String(format: "%0.2d:%0.2d:%0.2d", hours, minutes, seconds)
            
            let minutes = steps.interval! / 60
            let seconds = steps.interval! - minutes * 60
            chapterElementDurationLabel.text = NSString(format: "%02d:%02d", minutes,seconds) as String
        }
    }

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        sliderSegment.setThumbImage(UIImage(named: "thumb"), for: .normal)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
