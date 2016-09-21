//
//  ShoppingCarHeadView.h
//  ShoppingCar
//
//  Created by DY on 16/9/20.
//  Copyright © 2016年 DY. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ShoppingHeaderModel;
@class ShoppingCarHeadView;

@protocol  ShoppingCarHeaderViewDelegate<NSObject>

- (void)shoppingCarHeaderViewDelegat:(UIButton *)bt WithHeadView:(ShoppingCarHeadView *)view;

@end
@interface ShoppingCarHeadView : UIView

/**全选按钮*/
@property (nonatomic,strong) UIButton *selectAllBtn;

@property(nonatomic,assign)id<ShoppingCarHeaderViewDelegate>delegate;


//初始化方法
- (instancetype)initWithFrame:(CGRect)frame WithSection:(NSInteger)section HeadModel:(ShoppingHeaderModel *)model;

@end
