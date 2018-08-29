// Copyright 2018-present the Material Components for iOS authors. All Rights Reserved.
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

#import "MDCShapeCorner.h"

@implementation MDCShapeCorner

- (instancetype)init
{
  _isPercentage = NO;
  return [self initWithShapeFamily:MDCShapeFamilyRoundedCorner andSize:0];
}

- (instancetype)initWithShapeFamily:(MDCShapeFamily)shapeFamily andSize:(CGFloat)shapeSize
{
  if (self = [super init]) {
    _isPercentage = NO;
    _shapeFamily = shapeFamily;
    _shapeSize = shapeSize;
  }
  return self;
}

- (instancetype)initWithShapeFamily:(MDCShapeFamily)shapeFamily
                  andPercentageSize:(NSUInteger)shapeSize
{
  if (self = [super init]) {
    _isPercentage = YES;
    _shapeFamily = shapeFamily;
    _shapeSize = shapeSize;
  }
  return self;
}

- (MDCCornerTreatment *)cornerTreatmentValue {
  return [self cornerTreatmentSizeWithNormalizedShapeSize:_shapeSize];
}

- (MDCCornerTreatment *)cornerTreatmentValueWithViewBounds:(CGRect)bounds {
  MDCCornerTreatment *cornerTreatment;
  if (_isPercentage && _shapeSize <= 1) {
    CGFloat normalizedShapeSize = bounds.size.height * _shapeSize;
    cornerTreatment = [self cornerTreatmentSizeWithNormalizedShapeSize:normalizedShapeSize];
  } else {
    cornerTreatment = [self cornerTreatmentValue];
  }
  return cornerTreatment;
}

- (MDCCornerTreatment *)cornerTreatmentSizeWithNormalizedShapeSize:(CGFloat)shapeSize {
  MDCCornerTreatment *cornerTreatment;
  NSNumber *size = @(shapeSize);
  switch (_shapeFamily) {
    case MDCShapeFamilyAngledCorner:
      cornerTreatment =
          [[MDCCornerTreatment alloc] initWithCornerType:MDCCornerTypeCut
                                                 andSize:size];
      break;
    case MDCShapeFamilyRoundedCorner:
      cornerTreatment =
          [[MDCCornerTreatment alloc] initWithCornerType:MDCCornerTypeRounded
                                                 andSize:size];
      break;
  }
  return cornerTreatment;
}
@end
