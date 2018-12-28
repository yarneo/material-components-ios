// Copyright 2015-present the Material Components for iOS authors. All Rights Reserved.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

#import "MDCRippleView.h"
#import "private/MDCRippleLayer.h"

#import "MaterialMath.h"

@interface MDCRippleView () <CALayerDelegate, MDCRippleLayerDelegate>

@property(nonatomic, strong) MDCRippleLayer *activeRippleLayer;
@property(nonatomic, strong) CAShapeLayer *maskLayer;

@end

@implementation MDCRippleView {
  CGFloat _unboundedMaxRippleRadius;
}

- (instancetype)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    [self commonMDCRippleViewInit];
  }
  return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
  self = [super initWithCoder:aDecoder];
  if (self) {
    [self commonMDCRippleViewInit];
  }
  return self;
}

- (void)commonMDCRippleViewInit {
  self.userInteractionEnabled = NO;
  self.backgroundColor = [UIColor clearColor];
  self.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;

  _rippleColor = [[UIColor alloc] initWithWhite:0 alpha:(CGFloat)0.16];

  _rippleStyle = MDCRippleStyleBounded;
  self.layer.masksToBounds = YES;

  // Use mask layer when the superview has a shadowPath.
  _maskLayer = [CAShapeLayer layer];
  _maskLayer.delegate = self;
}

- (void)layoutSubviews {
  [super layoutSubviews];

  // this is for layout changes like landscape etc. should be moved to separate method.

//  CGRect inkBounds = CGRectMake(0, 0, CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds));
//  self.layer.bounds = inkBounds;
//
//  // When bounds change ensure all ink layer bounds are changed too.
//  for (CALayer *layer in self.layer.sublayers) {
//    if ([layer isKindOfClass:[MDCRippleLayer class]]) {
//      MDCRippleLayer *inkLayer = (MDCRippleLayer *)layer;
//      inkLayer.bounds = inkBounds;
//    }
//  }
  [self updateRippleStyle];
}

- (void)setRippleStyle:(MDCRippleStyle)rippleStyle {
  _rippleStyle = rippleStyle;
  [self updateRippleStyle];
}

- (void)updateRippleStyle {
  self.layer.masksToBounds = (self.rippleStyle == MDCRippleStyleBounded);
  if (self.rippleStyle == MDCRippleStyleBounded) {
    if (self.superview.layer.shadowPath) {
      self.maskLayer.path = self.superview.layer.shadowPath;
      self.layer.mask = _maskLayer;
    } else {
      self.superview.clipsToBounds = YES;
    }
  } else {
    self.layer.mask = nil;
    self.superview.clipsToBounds = NO;
  }
}

- (void)cancelAllRipplesAnimated:(BOOL)animated {
  NSArray<CALayer *> *sublayers = [self.layer.sublayers copy];
  if (animated) {
    CGFloat latestBeginPressDownRippleTime = CGFLOAT_MIN;
    for (CALayer *layer in sublayers) {
      if ([layer isKindOfClass:[MDCRippleLayer class]]) {
        MDCRippleLayer *rippleLayer = (MDCRippleLayer *)layer;
        latestBeginPressDownRippleTime =
            MAX(latestBeginPressDownRippleTime, rippleLayer.beginPressDownRippleTime);
      }
    }
    for (CALayer *layer in sublayers) {
      if ([layer isKindOfClass:[MDCRippleLayer class]]) {
        MDCRippleLayer *rippleLayer = (MDCRippleLayer *)layer;
        if (!rippleLayer.isStartAnimationActive) {
          rippleLayer.beginPressDownRippleTime = latestBeginPressDownRippleTime + (CGFloat)0.225;
        }
        [rippleLayer endRippleAnimated:animated completion:nil];
      }
    }
  } else {
    for (CALayer *layer in sublayers) {
      if ([layer isKindOfClass:[MDCRippleLayer class]]) {
        MDCRippleLayer *rippleLayer = (MDCRippleLayer *)layer;
        [rippleLayer removeFromSuperlayer];
      }
    }
  }
}

- (void)BeginRipplePressDownAtPoint:(CGPoint)point
                           animated:(BOOL)animated
                         completion:(nullable MDCRippleCompletionBlock)completion {
  MDCRippleLayer *rippleLayer = [MDCRippleLayer layer];
  rippleLayer.unboundedMaxRippleRadius = self.unboundedMaxRippleRadius;
  rippleLayer.rippleLayerDelegate = self;
  rippleLayer.fillColor = self.rippleColor.CGColor;
  rippleLayer.frame = self.bounds;
  [self.layer addSublayer:rippleLayer];
  [rippleLayer startRippleAtPoint:point animated:animated completion:completion];
  self.activeRippleLayer = rippleLayer;
}

- (void)BeginRipplePressUpAnimated:(BOOL)animated
                        completion:(nullable MDCRippleCompletionBlock)completion {
  [self.activeRippleLayer endRippleAnimated:animated completion:completion];
}

- (void)fadeInRippleAnimated:(BOOL)animated completion:(MDCRippleCompletionBlock)completion {
  [self.activeRippleLayer fadeInRippleAnimated:animated completion:completion];
}

- (void)fadeOutRippleAnimated:(BOOL)animated completion:(MDCRippleCompletionBlock)completion {
  [self.activeRippleLayer fadeOutRippleAnimated:animated completion:completion];
}

- (void)setActiveRippleColor:(UIColor *)rippleColor {
  if (rippleColor == nil) {
    return;
  }
  self.activeRippleLayer.fillColor = rippleColor.CGColor;
}

//+ (MDCInkView *)injectedInkViewForView:(UIView *)view {
//  MDCInkView *foundInkView = nil;
//  for (MDCInkView *subview in view.subviews) {
//    if ([subview isKindOfClass:[MDCInkView class]]) {
//      foundInkView = subview;
//      break;
//    }
//  }
//  if (!foundInkView) {
//    foundInkView = [[MDCInkView alloc] initWithFrame:view.bounds];
//    foundInkView.autoresizingMask =
//        UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
//    [view addSubview:foundInkView];
//  }
//  return foundInkView;
//}

#pragma mark - MDCRippleLayerDelegate

- (void)rippleLayerPressDownAnimationDidBegin:(MDCRippleLayer *)rippleLayer {
  if ([self.rippleViewDelegate respondsToSelector:@selector(ripplePressDownAnimationDidBegin:)]) {
    [self.rippleViewDelegate ripplePressDownAnimationDidBegin:self];
  }
}

- (void)rippleLayerPressDownAnimationDidEnd:(MDCRippleLayer *)rippleLayer {
  if ([self.rippleViewDelegate respondsToSelector:@selector(ripplePressDownAnimationDidEnd:)]) {
    [self.rippleViewDelegate ripplePressDownAnimationDidEnd:self];
  }
}

- (void)rippleLayerPressUpAnimationDidBegin:(MDCRippleLayer *)rippleLayer {
  if ([self.rippleViewDelegate respondsToSelector:@selector(ripplePressUpAnimationDidBegin:)]) {
    [self.rippleViewDelegate ripplePressUpAnimationDidBegin:self];
  }
}

- (void)rippleLayerPressUpAnimationDidEnd:(MDCRippleLayer *)rippleLayer {
  if ([self.rippleViewDelegate respondsToSelector:@selector(ripplePressUpAnimationDidEnd:)]) {
    [self.rippleViewDelegate ripplePressUpAnimationDidEnd:self];
  }
}

//#pragma mark - CALayerDelegate
//
//- (id<CAAction>)actionForLayer:(CALayer *)layer forKey:(NSString *)event {
//  if ([event isEqualToString:@"path"] || [event isEqualToString:@"shadowPath"]) {
//
//    // We have to create a pending animation because if we are inside a UIKit animation block we
//    // won't know any properties of the animation block until it is commited.
//    MDCInkPendingAnimation *pendingAnim = [[MDCInkPendingAnimation alloc] init];
//    pendingAnim.animationSourceLayer = self.superview.layer;
//    pendingAnim.fromValue = [layer.presentationLayer valueForKey:event];
//    pendingAnim.toValue = nil;
//    pendingAnim.keyPath = event;
//
//    return pendingAnim;
//  }
//  return nil;
//}

@end
