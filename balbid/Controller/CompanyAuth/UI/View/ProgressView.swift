//
//  ProgressView.swift
//  balbid
//
//  Created by Qamar Nahed on 17/12/2020.
//

import UIKit
class ProgressView: UIView {

    @IBOutlet weak var stepView: UIView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var stepNumberLabel: UILabel!
    let shapeLayer = CAShapeLayer()

    static func initFromNib() -> ProgressView {
        return Bundle.main.loadNibNamed(.progressView, owner: self, options: nil)!.first as! ProgressView
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        contentView.withShadow(alpha: 0.2, y: 3, blur: 10)
    }

     func setupLayerShape() {
        let circularPath = UIBezierPath(arcCenter: stepView.center, radius: 15, startAngle: -CGFloat.pi / 2, endAngle: 2 * CGFloat.pi, clockwise: true)
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.path = circularPath.cgPath
        shapeLayer.strokeColor = UIColor.appColor(.brownColor)?.cgColor
        shapeLayer.lineWidth = 4
        shapeLayer.strokeEnd = 0
        shapeLayer.lineCap = .round
        self.stepView.layer.addSublayer(shapeLayer)
    }

    func move(fromStep: Int, to step: Int) {
        let basicAnimation  = CABasicAnimation(keyPath: "strokeEnd")
        print("from value", CGFloat(fromStep)/5)
        print("to value", CGFloat(step)/5)
        basicAnimation.fromValue = CGFloat(fromStep)/5 == 0 ? CGFloat(fromStep)/5 :
            (CGFloat(fromStep)/5) - 0.1
        basicAnimation.toValue = (CGFloat(step)/5 ) - 0.1
        basicAnimation.duration = 1
        basicAnimation.fillMode = .forwards
        basicAnimation.isRemovedOnCompletion = false
        shapeLayer.add(basicAnimation, forKey: "steps")
        stepNumberLabel.text = "\(step)"
    }

}
