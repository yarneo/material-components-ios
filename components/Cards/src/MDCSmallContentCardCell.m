//
//  MDCSmallContentCardCell.m
//  MaterialComponents
//
//  Created by Yarden Eitan on 1/19/18.
//

#import "MDCSmallContentCardCell.h"
#import <MDFInternationalization/MDFInternationalization.h>
//#import "MaterialMath.h"
#import "MaterialTypography.h"

@implementation MDCSmallContentCardCell

- (instancetype)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    [self commonMDCSmallContentCardCellInit];
  }
  return self;
}

- (void)commonMDCSmallContentCardCellInit {
  _titleLabel = [[UILabel alloc] init];
  _titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
  _titleLabel.font = [MDCTypography subheadFont];
  _titleLabel.textColor = [UIColor colorWithWhite:0 alpha:[MDCTypography subheadFontOpacity]];
  _titleLabel.shadowColor = nil;
  _titleLabel.shadowOffset = CGSizeZero;
  _titleLabel.textAlignment = NSTextAlignmentNatural;
  _titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
  _titleLabel.numberOfLines = 1;
  _titleLabel.autoresizingMask =
    MDFTrailingMarginAutoresizingMaskForLayoutDirection(
      self.mdf_effectiveUserInterfaceLayoutDirection);
  _titleLabel.preferredMaxLayoutWidth = 200;
  [_titleLabel setContentHuggingPriority:UILayoutPriorityRequired
                                 forAxis:UILayoutConstraintAxisVertical];
  [_titleLabel setContentCompressionResistancePriority:UILayoutPriorityRequired
                                               forAxis:UILayoutConstraintAxisVertical];
  [self.contentView addSubview:_titleLabel];
  _subtitleLabel = [[UILabel alloc] init];
  _subtitleLabel.translatesAutoresizingMaskIntoConstraints = NO;
  _subtitleLabel.font = [MDCTypography subheadFont];
  _subtitleLabel.textColor = [UIColor colorWithWhite:0 alpha:[MDCTypography subheadFontOpacity]];
  _subtitleLabel.shadowColor = nil;
  _subtitleLabel.shadowOffset = CGSizeZero;
  _subtitleLabel.textAlignment = NSTextAlignmentNatural;
  _subtitleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
  _subtitleLabel.numberOfLines = 2;
  _subtitleLabel.autoresizingMask =
  MDFTrailingMarginAutoresizingMaskForLayoutDirection(
    self.mdf_effectiveUserInterfaceLayoutDirection);
  _subtitleLabel.preferredMaxLayoutWidth = 200;
  [_subtitleLabel setContentHuggingPriority:UILayoutPriorityRequired
                                 forAxis:UILayoutConstraintAxisVertical];
  [_subtitleLabel setContentCompressionResistancePriority:UILayoutPriorityRequired
                                               forAxis:UILayoutConstraintAxisVertical];
  [self.contentView addSubview:_subtitleLabel];
  _imageView = [[UIImageView alloc] init];
  _imageView.translatesAutoresizingMaskIntoConstraints = NO;
  [self.contentView addSubview:_imageView];
  _primaryAction = [[UIButton alloc] init];
  _primaryAction.translatesAutoresizingMaskIntoConstraints = NO;
  [_primaryAction setContentHuggingPriority:UILayoutPriorityRequired
                                    forAxis:UILayoutConstraintAxisHorizontal];
  [_primaryAction setContentCompressionResistancePriority:UILayoutPriorityRequired
                                                  forAxis:UILayoutConstraintAxisHorizontal];
  [self.contentView addSubview:_primaryAction];
  _secondaryAction = [[UIButton alloc] init];
  _secondaryAction.translatesAutoresizingMaskIntoConstraints = NO;
  [_secondaryAction setContentHuggingPriority:UILayoutPriorityRequired
                                    forAxis:UILayoutConstraintAxisHorizontal];
  [_secondaryAction setContentCompressionResistancePriority:UILayoutPriorityRequired
                                                  forAxis:UILayoutConstraintAxisHorizontal];
  [self.contentView addSubview:_secondaryAction];
  [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.titleLabel
                                                               attribute:NSLayoutAttributeLeft
                                                               relatedBy:NSLayoutRelationEqual
                                                                  toItem:self.contentView
                                                               attribute:NSLayoutAttributeLeft
                                                              multiplier:1.0
                                                                constant:16]];
  [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.titleLabel
                                                               attribute:NSLayoutAttributeTop
                                                               relatedBy:NSLayoutRelationEqual
                                                                  toItem:self.contentView
                                                               attribute:NSLayoutAttributeTop
                                                              multiplier:1.0
                                                                constant:16]];
  [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.titleLabel
                                                               attribute:NSLayoutAttributeRight
                                                               relatedBy:NSLayoutRelationEqual
                                                                  toItem:self.imageView
                                                               attribute:NSLayoutAttributeLeft
                                                              multiplier:1.0
                                                                constant:-16]];
  [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.imageView
                                                               attribute:NSLayoutAttributeTop
                                                               relatedBy:NSLayoutRelationEqual
                                                                  toItem:self.contentView
                                                               attribute:NSLayoutAttributeTop
                                                              multiplier:1.0
                                                                constant:16]];
  [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.imageView
                                                               attribute:NSLayoutAttributeRight
                                                               relatedBy:NSLayoutRelationEqual
                                                                  toItem:self.contentView
                                                               attribute:NSLayoutAttributeRight
                                                              multiplier:1.0
                                                                constant:-16]];
  [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.imageView
                                                               attribute:NSLayoutAttributeWidth
                                                               relatedBy:NSLayoutRelationEqual
                                                                  toItem:nil
                                                               attribute:NSLayoutAttributeNotAnAttribute
                                                              multiplier:1.0
                                                                constant:80]];
  [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.imageView
                                                               attribute:NSLayoutAttributeHeight
                                                               relatedBy:NSLayoutRelationEqual
                                                                  toItem:nil
                                                               attribute:NSLayoutAttributeNotAnAttribute
                                                              multiplier:1.0
                                                                constant:80]];
  [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.titleLabel
                                                               attribute:NSLayoutAttributeBottom
                                                               relatedBy:NSLayoutRelationEqual
                                                                  toItem:self.subtitleLabel
                                                               attribute:NSLayoutAttributeTop
                                                              multiplier:1.0
                                                                constant:-16]];
  [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.subtitleLabel
                                                               attribute:NSLayoutAttributeLeft
                                                               relatedBy:NSLayoutRelationEqual
                                                                  toItem:self.contentView
                                                               attribute:NSLayoutAttributeLeft
                                                              multiplier:1.0
                                                                constant:16]];
  [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.subtitleLabel
                                                               attribute:NSLayoutAttributeRight
                                                               relatedBy:NSLayoutRelationEqual
                                                                  toItem:self.imageView
                                                               attribute:NSLayoutAttributeLeft
                                                              multiplier:1.0
                                                                constant:-16]];
  [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.subtitleLabel
                                                               attribute:NSLayoutAttributeBottom
                                                               relatedBy:NSLayoutRelationLessThanOrEqual
                                                                  toItem:self.primaryAction
                                                               attribute:NSLayoutAttributeTop
                                                              multiplier:1.0
                                                                constant:-8]];
  [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.primaryAction
                                                               attribute:NSLayoutAttributeLeft
                                                               relatedBy:NSLayoutRelationEqual
                                                                  toItem:self.contentView
                                                               attribute:NSLayoutAttributeLeft
                                                              multiplier:1.0
                                                                constant:8]];
  [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.primaryAction
                                                               attribute:NSLayoutAttributeRight
                                                               relatedBy:NSLayoutRelationEqual
                                                                  toItem:self.secondaryAction
                                                               attribute:NSLayoutAttributeLeft
                                                              multiplier:1.0
                                                                constant:-8]];
  [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.primaryAction
                                                               attribute:NSLayoutAttributeBottom
                                                               relatedBy:NSLayoutRelationEqual
                                                                  toItem:self.contentView
                                                               attribute:NSLayoutAttributeBottom
                                                              multiplier:1.0
                                                                constant:-8]];
  [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.secondaryAction
                                                               attribute:NSLayoutAttributeBottom
                                                               relatedBy:NSLayoutRelationEqual
                                                                  toItem:self.contentView
                                                               attribute:NSLayoutAttributeBottom
                                                              multiplier:1.0
                                                                constant:-8]];
  [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.secondaryAction
                                                               attribute:NSLayoutAttributeTop
                                                               relatedBy:NSLayoutRelationGreaterThanOrEqual
                                                                  toItem:self.subtitleLabel
                                                               attribute:NSLayoutAttributeBottom
                                                              multiplier:1.0
                                                                constant:8]];
  [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.secondaryAction
                                                               attribute:NSLayoutAttributeTop
                                                               relatedBy:NSLayoutRelationGreaterThanOrEqual
                                                                  toItem:self.imageView
                                                               attribute:NSLayoutAttributeBottom
                                                              multiplier:1.0
                                                                constant:8]];
  [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.secondaryAction
                                                               attribute:NSLayoutAttributeRight
                                                               relatedBy:NSLayoutRelationGreaterThanOrEqual
                                                                  toItem:self.contentView
                                                               attribute:NSLayoutAttributeRight
                                                              multiplier:1.0
                                                                constant:-8]];

}

- (void)layoutSubviews {
  [super layoutSubviews];
}

@end
