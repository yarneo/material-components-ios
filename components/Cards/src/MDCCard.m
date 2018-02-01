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

#import "MDCCard.h"

#import "MaterialMath.h"

static NSString *const MDCCardShadowElevationsKey = @"MDCCardShadowElevationsKey";
static NSString *const MDCCardShadowColorsKey = @"MDCCardShadowColorsKey";
static NSString *const MDCCardBorderWidthsKey = @"MDCCardBorderWidthsKey";
static NSString *const MDCCardBorderColorsKey = @"MDCCardBorderColorsKey";
static NSString *const MDCCardInkViewKey = @"MDCCardInkViewKey";


@implementation MDCCard {
  NSMutableDictionary<NSNumber *, NSNumber *> *_shadowElevations;
  NSMutableDictionary<NSNumber *, UIColor *> *_shadowColors;
  NSMutableDictionary<NSNumber *, NSNumber *> *_borderWidths;
  NSMutableDictionary<NSNumber *, UIColor *> *_borderColors;
  CGPoint _lastTouch;
}

+ (Class)layerClass {
  return [MDCShadowLayer class];
}

- (instancetype)initWithCoder:(NSCoder *)coder {
  self = [super initWithCoder:coder];
  if (self) {
    _shadowElevations = [coder decodeObjectForKey:MDCCardShadowElevationsKey];
    _shadowColors = [coder decodeObjectForKey:MDCCardShadowColorsKey];
    _borderWidths = [coder decodeObjectForKey:MDCCardBorderWidthsKey];
    _borderColors = [coder decodeObjectForKey:MDCCardBorderColorsKey];
    _inkView = [coder decodeObjectForKey:MDCCardInkViewKey];
  }
  return self;
}

- (void)encodeWithCoder:(NSCoder *)coder {
  [super encodeWithCoder:coder];
  [coder encodeObject:_shadowElevations forKey:MDCCardShadowElevationsKey];
  [coder encodeObject:_shadowColors forKey:MDCCardShadowColorsKey];
  [coder encodeObject:_borderWidths forKey:MDCCardBorderWidthsKey];
  [coder encodeObject:_borderColors forKey:MDCCardBorderColorsKey];
  [coder encodeObject:_inkView forKey:MDCCardInkViewKey];
}

- (instancetype)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    [self commonMDCCardInit];
  }
  return self;
}

- (void)commonMDCCardInit {
  _inkView = [[MDCInkView alloc] initWithFrame:self.bounds];
  _inkView.autoresizingMask = (UIViewAutoresizingFlexibleWidth |
                               UIViewAutoresizingFlexibleHeight);
  _inkView.usesLegacyInkRipple = NO;
  _inkView.layer.zPosition = FLT_MAX;
  [self addSubview:self.inkView];

  _shadowElevations = [NSMutableDictionary dictionary];
  _shadowElevations[@(UIControlStateNormal)] = @(1.f);
  _shadowElevations[@(UIControlStateHighlighted)] = @(8.f);

  _shadowColors = [NSMutableDictionary dictionary];
  _shadowColors[@(UIControlStateNormal)] = [UIColor blackColor];

  _borderColors = [NSMutableDictionary dictionary];

  _borderWidths = [NSMutableDictionary dictionary];
  _borderWidths[@(UIControlStateNormal)] = @(0.f);
}

- (void)layoutSubviews {
  [super layoutSubviews];

  [self updateShadowElevation];
  [self updateShadowColor];
  [self updateBorderWidth];

  self.cornerRadius = 4.f;
  self.layer.shadowPath = [self boundingPath].CGPath;
}

- (void)setCornerRadius:(CGFloat)cornerRadius {
  self.layer.cornerRadius = cornerRadius;
}

- (CGFloat)cornerRadius {
  return self.layer.cornerRadius;
}

- (UIBezierPath *)boundingPath {
  CGFloat cornerRadius = self.cornerRadius;
  return [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:cornerRadius];
}

- (MDCShadowElevation)shadowElevationForState:(UIControlState)state {
  NSNumber *elevation = _shadowElevations[@(state)];
  if (state != UIControlStateNormal && elevation == nil) {
    elevation = _shadowElevations[@(UIControlStateNormal)];
  }
  if (elevation != nil) {
    return (CGFloat)[elevation doubleValue];
  }
  return 0;
}

- (void)setShadowElevation:(MDCShadowElevation)shadowElevation forState:(UIControlState)state {
  _shadowElevations[@(state)] = @(shadowElevation);

  [self updateShadowElevation];
}

- (void)updateShadowElevation {
  CGFloat elevation = [self shadowElevationForState:self.state];
  if (!MDCCGFloatEqual(((MDCShadowLayer *)self.layer).elevation, elevation)) {
    self.layer.shadowPath = [self boundingPath].CGPath;
    [(MDCShadowLayer *)self.layer setElevation:elevation];
  }
}

- (void)setBorderWidth:(CGFloat)borderWidth forState:(UIControlState)state {
  _borderWidths[@(state)] = @(borderWidth);

  [self updateBorderWidth];
}

- (void)updateBorderWidth {
  CGFloat borderWidth = [self borderWidthForState:self.state];
  self.layer.borderWidth = borderWidth;
}

- (CGFloat)borderWidthForState:(UIControlState)state {
  NSNumber *borderWidth = _borderWidths[@(state)];
  if (state != UIControlStateNormal && borderWidth == nil) {
    borderWidth = _borderWidths[@(UIControlStateNormal)];
  }
  if (borderWidth != nil) {
    return (CGFloat)[borderWidth doubleValue];
  }
  return 0;
}

- (void)setBorderColor:(UIColor *)borderColor forState:(UIControlState)state {
  _borderColors[@(state)] = borderColor;

  [self updateBorderColor];
}

- (void)updateBorderColor {
  CGColorRef borderColorRef = [self borderColorForState:self.state].CGColor;
  self.layer.borderColor = borderColorRef;
}

- (UIColor *)borderColorForState:(UIControlState)state {
  UIColor *borderColor = _borderColors[@(state)];
  if (state != UIControlStateNormal && borderColor == nil) {
    borderColor = _borderColors[@(UIControlStateNormal)];
  }
  return borderColor;
}

- (void)setShadowColor:(UIColor *)shadowColor forState:(UIControlState)state {
  _shadowColors[@(state)] = shadowColor;

  [self updateShadowColor];
}

- (void)updateShadowColor {
  CGColorRef shadowColor = [self shadowColorForState:self.state].CGColor;
  self.layer.shadowColor = shadowColor;
}

- (UIColor *)shadowColorForState:(UIControlState)state {
  UIColor *shadowColor = _shadowColors[@(state)];
  if (state != UIControlStateNormal && shadowColor == nil) {
    shadowColor = _shadowColors[@(UIControlStateNormal)];
  }
  if (shadowColor != nil) {
    return shadowColor;
  }
  return [UIColor blackColor];
}

- (void)setHighlighted:(BOOL)highlighted {
  [super setHighlighted: highlighted];
  if (highlighted) {
    /**
     Note: setHighlighted might get more touches began than touches ended hence the call
     hence the call to startTouchEndedAnimationAtPoint before.
     */
    [self.inkView startTouchEndedAnimationAtPoint:_lastTouch completion:nil];
    [self.inkView startTouchBeganAnimationAtPoint:_lastTouch completion:nil];
  } else {
    [self.inkView startTouchEndedAnimationAtPoint:_lastTouch completion:nil];
  }
  [self updateShadowElevation];
  [self updateBorderColor];
  [self updateBorderWidth];
  [self updateShadowColor];
}

- (BOOL)beginTrackingWithTouch:(UITouch *)touch withEvent:(nullable UIEvent *)event {
  BOOL beginTracking = [super beginTrackingWithTouch:touch withEvent:event];
  CGPoint location = [touch locationInView:self];
  _lastTouch = location;
  return beginTracking;
}

@end
