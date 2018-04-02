/*
 Copyright 2018-present the Material Components for iOS authors. All Rights Reserved.

 Licensed under the Apache License, Version 2.0 (the "License");
 you may not use this file except in compliance with the License.
 You may obtain a copy of the License at

 http://www.apache.org/licenses/LICENSE-2.0

 Unless required by applicable law or agreed to in writing, software
 distributed under the License is distributed on an "AS IS" BASIS,
 WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 See the License for the specific language governing permissions and
 limitations under the License.
 */

import UIKit

@available(iOS 9.0, *)
class CardView: MDCCard {

  let contentView = UIView()
  let label = UILabel()
  let imageView = UIImageView()

  var imageWidthConstraint: NSLayoutConstraint!
  var shouldUpdateConstraints = true

  override init(frame: CGRect) {
    super.init(frame: frame)
    commonCardViewInit()
  }

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    commonCardViewInit()
  }

  func commonCardViewInit() {
    self.layoutMargins = UIEdgeInsets(top: 0, left: 0, bottom: 10, right: 0)
    contentView.layoutMargins = .zero
    contentView.translatesAutoresizingMaskIntoConstraints = false
    contentView.isUserInteractionEnabled = false
    self.addSubview(contentView)

    label.text = "abcde fghi jklm nopq rstuv wxyz abcd efgh ijkl mnop qrst uvw xyz abcde fghi jkl" +
      "nopq rstuv wxyz abcd efgh ijkl mnop qrst uvw xyz abcde fghi jklm nopq rstuv wxyz abcdefg" +
    "efgh ijkl mnop qrst uvw xyz abcde fghi jklm nopq rstuv wxyz abcd efgh ijkl abcd efghijkl"
    label.numberOfLines = 0
    label.translatesAutoresizingMaskIntoConstraints = false
    self.contentView.addSubview(label)

    imageView.clipsToBounds = true
    imageView.contentMode = .scaleAspectFill
    imageView.translatesAutoresizingMaskIntoConstraints = false
    let bundle = Bundle(for: ShapedCardViewController.self)
    imageView.image = UIImage(named: "sample-image", in: bundle, compatibleWith: nil)
    self.contentView.addSubview(imageView)
    setupConstraints()
  }

  func setupConstraints() {
    contentView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
    contentView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
    contentView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
    contentView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true

    let margins = self.contentView.layoutMarginsGuide
    label.leadingAnchor.constraint(equalTo: margins.leadingAnchor).isActive = true
    label.trailingAnchor.constraint(equalTo: margins.trailingAnchor).isActive = true
    imageView.centerXAnchor.constraint(equalTo: margins.centerXAnchor).isActive = true

    imageView.topAnchor.constraint(equalTo: self.contentView.topAnchor).isActive = true
    label.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor).isActive = true

    imageView.bottomAnchor.constraint(equalTo: label.topAnchor).isActive = true
    imageView.heightAnchor.constraint(equalTo: label.heightAnchor, multiplier: 1).isActive = true

    imageWidthConstraint = imageView.widthAnchor.constraint(equalToConstant: 0)
    imageWidthConstraint.isActive = true
  }

  override func layoutSubviews() {
    super.layoutSubviews()
    let shapeLayer = (self.layer as! MDCShapedShadowLayer).shapeLayer
    contentView.layer.mask = shapeLayer
    imageWidthConstraint.constant = shapeLayer.path!.boundingBox.size.width
  }

}

@available(iOS 9.0, *)
class ShapedCardViewController: UIViewController {
  var card = CardView()
  var primarySlider = UISlider()
  var secondarySlider = UISlider()

  override func viewDidLoad() {
    view.backgroundColor = .white
    super.viewDidLoad()

    initialShape()

    view.addSubview(card)
    view.addSubview(primarySlider)
    view.addSubview(secondarySlider)

    card.translatesAutoresizingMaskIntoConstraints = false
    card.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor, constant: 20).isActive = true
    card.bottomAnchor.constraint(equalTo: primarySlider.topAnchor, constant: -20).isActive = true
    card.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor).isActive = true
    card.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor).isActive = true

    primarySlider.translatesAutoresizingMaskIntoConstraints = false
    primarySlider.bottomAnchor.constraint(equalTo: secondarySlider.topAnchor, constant: -20).isActive = true
    primarySlider.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    primarySlider.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5, constant: 0).isActive = true

    secondarySlider.translatesAutoresizingMaskIntoConstraints = false
    secondarySlider.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20).isActive = true
    secondarySlider.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    secondarySlider.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5, constant: 0).isActive = true

    let barButton = UIBarButtonItem(title: "Change Shape",
                                    style: .plain,
                                    target: self,
                                    action: #selector(changeShape))
    self.navigationItem.rightBarButtonItem = barButton
  }

  override public var traitCollection: UITraitCollection {
    if UIDevice.current.userInterfaceIdiom == .pad && UIDevice.current.orientation.isPortrait {
      return UITraitCollection(traitsFrom:[UITraitCollection(horizontalSizeClass: .compact),
                                           UITraitCollection(verticalSizeClass: .regular)])
    }
    return super.traitCollection
  }

  func changeShape() {
    switch(card.shapeGenerator) {
    case is MDCRectangleShapeGenerator:
      let shapeGenerator = MDCCurvedRectShapeGenerator(cornerSize: CGSize(width: 20,
                                                                          height: 100))
      card.shapeGenerator = shapeGenerator
    case is MDCCurvedRectShapeGenerator:
      let shapeGenerator = MDCPillShapeGenerator()
      card.shapeGenerator = shapeGenerator
    case is MDCPillShapeGenerator:
      let shapeGenerator = MDCSlantedRectShapeGenerator()
      shapeGenerator.slant = 80
      card.shapeGenerator = shapeGenerator
    case is MDCSlantedRectShapeGenerator:
      fallthrough
    default:
      initialShape()
    }
    card.setNeedsLayout()
  }

  func initialShape() {
    let shapeGenerator = MDCRectangleShapeGenerator()
    let cutCornerTreatment = MDCCutCornerTreatment(cut: 100)
    shapeGenerator.setCorners(cutCornerTreatment)
    let triangleEdgeTreatment = MDCTriangleEdgeTreatment(size: 30, style: MDCTriangleEdgeStyleCut)
    shapeGenerator.setEdges(triangleEdgeTreatment)
    card.shapeGenerator = shapeGenerator
  }
}

@available(iOS 9.0, *)
extension ShapedCardViewController {
  @objc class func catalogBreadcrumbs() -> [String] {
    return ["Cards", "Shaped Card"]
  }

  @objc class func catalogIsPresentable() -> Bool {
    return true
  }

  @objc class func catalogIsDebug() -> Bool {
    return true
  }
}

extension UIView {
  func mask(withRect rect: CGRect, inverse: Bool = false) {
    let path = UIBezierPath(rect: rect)
    let maskLayer = CAShapeLayer()

    if inverse {
      path.append(UIBezierPath(rect: self.bounds))
      maskLayer.fillRule = kCAFillRuleEvenOdd
    }

    maskLayer.path = path.cgPath

    self.layer.mask = maskLayer
  }

  func mask(withPath path: UIBezierPath, inverse: Bool = false) {
    let path = path
    let maskLayer = CAShapeLayer()

    if inverse {
      path.append(UIBezierPath(rect: self.bounds))
      maskLayer.fillRule = kCAFillRuleEvenOdd
    }

    maskLayer.path = path.cgPath

    self.layer.mask = maskLayer
  }
}
