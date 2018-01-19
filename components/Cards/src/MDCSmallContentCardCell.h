//
//  MDCSmallContentCardCell.h
//  MaterialComponents
//
//  Created by Yarden Eitan on 1/19/18.
//

#import "MaterialCards.h"

@interface MDCSmallContentCardCell : MDCCollectionViewCardCell

@property(nonatomic, readonly, strong, nullable) UILabel *titleLabel;
@property(nonatomic, readonly, strong, nullable) UILabel *subtitleLabel;
@property(nonatomic, readonly, strong, nullable) UIImageView *imageView;
@property(nonatomic, readonly, strong, nullable) UIButton *primaryAction;
@property(nonatomic, readonly, strong, nullable) UIButton *secondaryAction;

@end
