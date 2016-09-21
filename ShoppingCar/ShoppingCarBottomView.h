//
//  ShoppingCarBottomView.h
//  ShoppingCar
//
//  Created by DY on 16/9/20.
//  Copyright © 2016年 DY. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ShoppingCarBottomModel;
@class ShoppingCarBottomView;

@protocol ShoppingCarBottomViewDelegate <NSObject>

- (void)shoppingcarBottomViewDelegate:(UIButton *)allselBtn;

@end

@interface ShoppingCarBottomView : UIView


/**模型属性控制bt的状态*/
@property(nonatomic,strong)ShoppingCarBottomModel * bottomModel;
/**全选按钮*/
@property(nonatomic,strong)UIButton * allselectBtn;
/**总价label*/
@property(nonatomic,strong)UILabel * resultPriceLl;
/**总价label*/
@property(nonatomic,strong)void(^settleBlock)();
/**总价label*/
@property(nonatomic,assign)id<ShoppingCarBottomViewDelegate>delegate;

//初始化方法
- (instancetype)initWithFrame:(CGRect)frame With:(ShoppingCarBottomModel*)bottomModel;

@end
