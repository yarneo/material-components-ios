// Copyright 2019-present the Material Components for iOS authors. All Rights Reserved.
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

#import "MDCCardCollectionCell.h"

@interface MDCCardCollectionCell (Private)

// These properties matches the same properties in MDCCardCollectionCell.m
@property(nonatomic, strong, nonnull) UIView *rippleView;
@property(nonatomic, getter=isDragged) BOOL dragged;
@property(nonatomic, strong, nullable) UIImageView *selectedImageView;

- (void)updateShadowElevation;
- (void)updateBorderColor;
- (void)updateBorderWidth;
- (void)updateShadowColor;
- (void)updateImage;
- (void)updateImageAlignment;
- (void)updateImageTintColor;
- (nullable UIImage *)imageForState:(MDCCardCellState)state;
- (nullable UIColor *)imageTintColorForState:(MDCCardCellState)state;

@end
